class HomeController < ApplicationController
  def index
  	if !current_user.nil?
  		@instructor = current_user.instructor
      @upcoming_camps = @instructor.camps.upcoming.chronological.map { |e| e.name }
      @registration_count = @instructor.camps.upcoming.chronological.map { |camp| Registration.where("camp_id = ?", camp.id).count  }
  	  @camp_to_registration = Hash[@upcoming_camps.zip @registration_count]
      # redirect_to @instructor, notice: "#{@camp_to_registration}"
    end
  end

  def about
  end

  def contact
  end

  def privacy
  end
  
end
