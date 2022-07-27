class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :restricted_access_to_admin

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      respond_to do |format|
        format.html { redirect_to dashboard_admin_path, notice: 'L\'utilisateur a bien été modifié' }
        format.js {}
      end
    else
      flash[:alert] = "Une erreur inattendue s'est produite"
    end
  end

  def set_approval
    @user = User.find(params[:id])
    @user.update(approved: !@user.approved?)
      if @user.save
        respond_to do |format|
        format.html { redirect_to dashboard_admin_path, flash: {notice: "L'utilisateur a bien été #{!@user.approved? ? 'dés' : ''}activé"} }
        format.js {}
        end
      else
        flash[:alert] = "Une erreur inattendue s'est produite"
      end
  end

  def reject
    @user = User.find(params[:id])
    @user.destroy!
    
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
    params.require(:user).permit(:username, :first_name, :last_name, :adress, :zipcode, :city, :email, :role, :approved, :password, :password_confirmation, specialities: [])
  end

end
