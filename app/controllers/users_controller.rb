class UsersController < ApplicationController
	# before_action :check_login

  def new
  	@user = User.new
  end

  def edit
  	@user = @current_user
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		session[:user_id] = @user.user_id
  		redirect_to(home_path, notice: "User was successfully created.")
  	else
  		render action: 'edit'
  	end
  end

  def update
  	@user = @current_user
  	if @user.save
  		redirect_to(@user, notice: "User was successfully updated in the system.")
  	else
  		render action: 'edit'
  	end
  end

  private
  def set_user
      @user = User.find(params[:id])
    end
    
  def user_params
  	params.require(:user).permit(:password, :password_confirmation, :username, :role, :instructor_id, :password_digest, :active)
  	
  end
end
