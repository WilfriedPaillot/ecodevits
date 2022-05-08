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
    @user_trainings = current_user.trainings
    if @user_trainings.empty?
      flash[:alert] = 'Vous n\'avez pas encore de cours'
      render dashboard_index_path
    else
      @my_trainings = current_user.trainings
    end
  end

  def instructor
  end

  def admin
  end
end
