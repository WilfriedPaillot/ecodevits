class TrainingsUsersController < ApplicationController
  before_action :authenticate_user!

  def new
    @training = Training.find(params[:training_id])
  end

  def create
    if current_user.training_ids.include?(params[:training_id].to_i)
      flash[:alert] = 'Vous êtes déjà inscrit à ce cours'
    else
      @training = Training.find(params[:training_id])
      @training_user = TrainingsUser.new(training_id: @training.id, user_id: current_user.id)
      if @training_user.save
        flash[:notice] = 'Félicitations, vous êtes désormais inscrit à ce cours'
      end
    end
    redirect_to dashboard_index_path
  end
end
