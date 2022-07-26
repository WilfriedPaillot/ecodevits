class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :can_edit_lesson?, only: [:new, :edit, :update, :destroy]

  def index
  end

  def show
    @lesson = Lesson.find(params[:id])
    @training = @lesson.section.training
    @section = @lesson.section
  end

  def new
    @lesson = Lesson.new
    @section = Section.find(params[:section_id])
    @training = @section.training
  end

  def edit
    @lesson = Lesson.find(params[:id])
    @section = @lesson.section
    @training = @section.training
  end

  def update
    if @lesson.update(lesson_params)
      redirect_to training_path(@lesson.section.training)
    else
      redirect_to :back, flash[:alert] = 'Leçon non mise à jour.'
    end
  end

  def create
    @lesson = Lesson.new(lesson_params).tap do |lesson|
      lesson.section_id = params[:section_id]
    end
    if @lesson.save
      redirect_to training_path(@lesson.section.training)
    else
      redirect_to @lesson, flash[:alert] = 'Leçon non créée.'
    end
  end

  def destroy
  end
  
  private
    def lesson_params
      params.require(:lesson).permit(:title, :content, :section_id, :lessons_completed, :completed, :video, :url, :thumbnail, documents: [])
    end

    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    def can_edit_lesson?
      unless current_user.admin? || current_user.id == (Training.find(params[:training_id]).user_id) 
        redirect_to trainings_url, flash[:alert] = 'Bien essayé, mais vous n\'avez pas accès à cette page.'
      end
    end
end
