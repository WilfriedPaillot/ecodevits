class StaticPagesController < ApplicationController
  def homepage
    @latest_trainings = Training.with_attached_thumbnail.latest(3)
  end

  def contact
  end

  def about
  end

  def instructor
    respond_to do |format|
      format.html { render :template => 'devise/registrations/new'}
    end
  end
end
