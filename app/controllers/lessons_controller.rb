class LessonsController < ApplicationController
  def index
  end

  def show
    @lesson = Lesson.find(params[:id])
    @training = @lesson.section.training
    @section = @lesson.section
  end

  def new
  end

  def edit
  end

  def update
    @lesson = Lesson.find(params[:id])
    if @lesson.isnt_last_lesson?
      redirect_to @lesson.next
    elsif @lesson.next_section?
      redirect_to @lesson.first_of_next_section
    else
      redirect_to dashboard_index_path, notice: "Félicitations, vous avez terminé la formation #{@lesson.section.training.title} !"
    end
  end

  def create
  end

  def destroy
  end
  
  private
    def lesson_params
      params.require(:lesson).permit(:title, :content, :section_id)
    end

end
