class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.student?
      redirect_to dashboard_student_path
    elsif current_user.instructor?
      redirect_to dashboard_instructor_path
    else current_user.admin?
      redirect_to dashboard_admin_path
    end
  end

  def student
    @user_trainings = current_user.user_trainings
    if @user_trainings.empty?
      flash[:alert] = 'Vous n\'avez pas encore de formations'
      redirect_to catalogue_index_path
    else
      @my_trainings = @user_trainings.map { |user_training| user_training.training }
    end
  end

  def instructor
  end

  def admin
  end
end
