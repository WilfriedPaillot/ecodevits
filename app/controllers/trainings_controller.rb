class TrainingsController < ApplicationController
  before_action :set_training, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :can_edit_training?, only: [:edit, :update, :destroy]

  def index
    unless params[:search].blank? || params[:search].empty?
      @trainings = Training.search(params[:search]).order_desc
        if @trainings.empty?
          flash[:alert] = "Aucun résultat pour \"#{params[:search]}\""
          @trainings = Training.with_attached_thumbnail.order_desc
        end
    else
      @trainings = Training.with_attached_thumbnail.order_desc
    end
  end

  def show
  end

  def new
    @training = Training.new
  end

  def edit
  end

  def create
    @training = Training.new(training_params).tap do |training|
      training.user_id = current_user.id
    end
    if @training.save
      redirect_to @training, notice: 'Formation créée avec succès.'
    else
      render :new
    end
  end

  def update
    if @training.update(training_params)
      redirect_to @training, notice: 'Formation mise à jour avec succès.'
    else
      render :edit
    end
  end

  def destroy
    @training.destroy
    redirect_to dashboard_index_path, notice: 'Formation supprimée avec succès.'
  end


  private
    def set_training
      @training = Training.find(params[:id])
    end

    def training_params
      params.require(:training).permit(:title, :description, :user_id, :thumbnail)
    end

    def can_edit_training?
      unless current_user.admin? || current_user == @training.user
        redirect_to trainings_url, notice: 'Bien essayé, mais vous n\'avez pas accès à cette page.'
      end
    end

end
