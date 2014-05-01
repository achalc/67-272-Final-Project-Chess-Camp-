class LocationsController < ApplicationController
  def index
  	@active_locations = Location.active.alphabetical.paginate(page: params[:page])
  	@inactive_locations = Location.inactive.alphabetical.paginate(page: params[:page])
  end

  def show

  end

  def new
  	@location = Location.new
  end

  def edit
  end

  def create
  	@location = Location.new(location_params)
  	if @location.save
  		redirect_to @location, notice: "#{@location.name} was added to the system."
  	else
  		render action:'new'
  	end
  end

  def update
  	if @location.update(location_params)
  		redirect_to @location, notice: "#{@location.name} was revised in the system."
  	else
  		render action: 'edit'
  	end
  end

  def destroy
  	@location.destroy
  	redirect_to locations_path, notice: "#{@location.name} was removed from the system."
  end
end
