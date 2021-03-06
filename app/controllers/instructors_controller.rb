class InstructorsController < ApplicationController
  include ActionView::Helpers::NumberHelper
  before_action :check_login
  skip_before_action :check_login, only: [:index, :show]
  before_action :set_instructor, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @active_instructors = Instructor.active.alphabetical.paginate(:page => params[:page]).per_page(10)
    @inactive_instructors = Instructor.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  def show
    @upcoming_camps = @instructor.camps.upcoming.chronological
    @past_camps = @instructor.camps.past.chronological
    # @user
  end

  def new
    @instructor = Instructor.new
    @user = @instructor.build_user
  end

  def edit
    # reformating the phone so it has dashes when displayed for editing (personal taste)
    @instructor.phone = number_to_phone(@instructor.phone)
    @instructor = Instructor.find(params[:id])
    if @instructor.user.nil?
      @user = @instructor.build_user
    end
  end

  def create
    @instructor = Instructor.new(instructor_params)
    if @instructor.save
      redirect_to @instructor, notice: "#{@instructor.proper_name} was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    if @instructor.update(instructor_params)
      redirect_to @instructor, notice: "#{@instructor.proper_name} was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @instructor.destroy
    redirect_to instructors_url, notice: "#{@instructor.proper_name} was removed from the system."
  end

  private
    def set_instructor
      @instructor = Instructor.find(params[:id])
    end

    def instructor_params
      params.require(:instructor).permit(:id, :first_name, :last_name, :bio, :email, :phone, :active, :picture, user_attributes: [:id, :username, :password, :password_confirmation, :role, :active])
    end
end
