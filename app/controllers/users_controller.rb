class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :restricted_access_to_admin

  # def index
  #   @users = User.excluding_admins.ordered_by_role_and_last_name
  #   @user_approval = User.where(role: "instructor").order(:created_at)
  #   @unapproved_user = @users.where(approved: false)
  # end

  def set_approval
    @user = User.find(params[:id])
    state = @user.approved? ? false : true
    @user.update(approved: state)
    respond_to do |format|
      format.html { redirect_to dashboard_admin_path }
      format.js {}
    end
  end

  def reject
    @user = User.find(params[:id])
    @user.destroy
    
    respond_to do |format|
      format.html { redirect_to dashboard_admin_path }
      format.js {}
    end
  end

  
  private
  def restricted_access_to_admin
    if !current_user.admin?
      flash[:alert] = "Vous n'avez pas accès à cette page"
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:username, :first_name, :last_name, :adress, :zipcode, :city, :email, :role, :approved, :password, :password_confirmation)
  end

end
