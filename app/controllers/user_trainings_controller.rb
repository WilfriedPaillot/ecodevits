class UserTrainingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_trainings = current_user.user_trainings.includes(:training).order(:created_at)
  end

  def show
    @user_training = UserTraining.find(params[:id])
  end

  def new
    @user_training = UserTraining.new(user_training_params)
  end

  def create
    training = Training.find(params[:training_id])
    if current_user.training_ids.include?(params[:training_id].to_i)
      flash[:alert] = "Vous êtes déjà inscrit à #{training.title}"
    else
      @user_training = UserTraining.create!(training_id: params[:training_id], user_id: current_user.id)
      if @user_training.save
        flash[:notice] = "Félicitations, vous êtes désormais inscrit à #{training.title}"
      end
    end
    redirect_to dashboard_index_path
  end

  def update
    user_training = UserTraining.find(params[:id])
    @lesson = Lesson.find(params[:lesson])
    @section = @lesson.section
    @training = @lesson.section.training

    unless user_training.completed?
      unless user_training.lessons_completed.include?(@lesson.id.to_s)
        user_training.update(lessons_completed: user_training.lessons_completed.push(@lesson.id))
        if user_training.lessons_completed.length == @training.lessons.length
          user_training.update(completed: 1)
        end
        user_training.save!
      end
    end
    # redirect to training section lesson path with next lesson or next section
    if @lesson.isnt_last_lesson?
      redirect_to training_section_lesson_path(@training, @section, @lesson.next)
    elsif @lesson.next_section?
      @next_section = @section.id.to_i + 1 
      redirect_to training_section_lesson_path(@training, @next_section, @lesson.first_of_next_section)
    else
      redirect_to dashboard_index_path, notice: "Félicitations, vous avez terminé la formation #{@lesson.section.training.title} !"
    end
  end

  private
  def user_training_params
    params.require(:user_training).permit(:training_id, :user_id, :completed, lessons_completed: [])
  end
end
