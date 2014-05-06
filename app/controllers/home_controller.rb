class HomeController < ApplicationController
  def index
  	if !current_user.nil?
  		@instructor = current_user.instructor
  	end
  end

  def about
  end

  def contact
  end

  def privacy
  end
  
end
