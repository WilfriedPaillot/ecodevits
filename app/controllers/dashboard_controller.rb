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
      @my_trainings = @user_trainings
    end
    # @user_training = @user_trainings.find_by(training_id: params[:training])
    @user_training = @user_trainings.find_by(training_id: params[:id])
  end

  def instructor
    @published_trainings = Training.where(user_id: current_user.id)
    @followed_trainings = current_user.user_trainings
    @followed_training = @followed_trainings.find_by(training_id: params[:id])
  end

  def admin
    @users = User.where.not(role: "admin").order(:role, :last_name)
    @user_approval = User.where(role: "instructor").order(:created_at)
    @instructors = User.where(role: "instructor").order(:created_at)
    @unapproved_user = @instructors.where(approved: false)
  end

end
