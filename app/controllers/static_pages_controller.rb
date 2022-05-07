class StaticPagesController < ApplicationController
  def homepage
    @latest_trainings = Training.latest(3)
  end

  def contact
  end

  def about
  end
end
