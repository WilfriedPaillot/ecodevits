class StaticPagesController < ApplicationController
  def homepage
    @latest_trainings = Training.with_attached_thumbnail.latest(3)
  end

  def contact
  end

  def about
  end

  def instructor
    user = current_user
    respond_to do |format|
      if user.nil?
        format.html { render :template => 'devise/registrations/new'}
      elsif user.role == "student" && request.path.include?("devenir-instructeur")
        format.html { render :template => 'devise/registrations/edit'}
      end
    end
  end

end