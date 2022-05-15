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
  end

  def instructor
  end

  def admin
    #@users = User.excluding_admins.ordered_by_role_and_last_name
    @users = User.where.not(role: "admin").order(:role, :last_name)
    # @user_approval = User.only_instructors.order(:created_at)
    @user_approval = User.where(role: "instructor").order(:created_at)
    # @approved_user = @users.where(approved: true)
    @unapproved_user = @users.where(approved: false)
  end

end
