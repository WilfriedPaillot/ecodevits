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
  end

  def create
  end

  def destroy
  end
  
  private
    def lesson_params
      params.require(:lesson).permit(:title, :content, :section_id, :lessons_completed, :completed, :video, :url, :thumbnail, documents: [])
    end

end
