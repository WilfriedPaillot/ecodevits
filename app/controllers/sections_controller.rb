class SectionsController < ApplicationController
  before_action :set_section, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :can_edit_section?, only: [:new, :edit, :update, :destroy]

  def new
    @section = Section.new
    @training = Training.find(params[:training_id])
  end

  def create
    @section = Section.new(section_params).tap do |section|
      section.training_id = params[:training_id]
    end
    if @section.save
      redirect_to training_path(params[:training_id]), notice: 'Section créée avec succès.'
    else
      render :new
    end
  end

  def edit
    @section = Section.find(params[:id])
  end

  def update
    @section = Section.find(params[:id])
    if @section.update(section_params)
      redirect_to training_path(@section.training_id), notice: 'Section mise à jour avec succès.'
    else
      render :edit
    end
  end

  private
  def set_section
    @section = Section.find(params[:id])
  end
  
  def section_params
    params.require(:section).permit(:title, :description, :training_id)
  end

  def can_edit_section?
    unless current_user.admin? || current_user.id == (Training.find(params[:training_id]).user_id) 
      redirect_to trainings_url, notice: 'Bien essayé, mais vous n\'avez pas accès à cette page.'
    end
  end

end
