class UsersController < ApplicationController
	# before_action :check_login
  skip_before_action :check_login, only: [:new, :create]

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
    # @user.update_attributes(:user_params)
  	if @user.save
  		redirect_to(@user, notice: "User was successfully updated in the system.")
  	else
  		render action: 'edit'
  	end
  end

  def show
    # change this so it goes to the users own page
    redirect_to(user_path)
  end

  private
  def set_user
      @user = User.find(params[:id])
    end
    
  def user_params
    if current_user && current_user.role?(:admin)
      params.require(:user).permit(:password, :password_confirmation, :username, :role, :active)
  	else
      params.require(:user).permit(:password, :password_confirmation, :username, :active)
    end 
  end

end
