class RegistrationsController < ApplicationController


  def new
  	@registration = Registration.new
  end

  def create
  	@registration = Registration.new(registration_params)
  	if @registration.save
  		redirect_to(student_path, notice: "Student was successfully registered for the camp")
  	else
  		render action: 'edit'
  	end
  end

  def update
  	if @registration.update(registration_params)
  		redirect_to(student_path, notice: "Registration was successfully updated in the system.")
  	else
  		render action: 'edit'
  	end
  end

  def edit
  end

  private
  def registration_params
  	params.require(:registration).permit(:id, :camp_id, :student_id, :payment_status, :points_earned)
  end
end
