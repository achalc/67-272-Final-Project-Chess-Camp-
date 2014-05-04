class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)
      # if user.admin?
      #   can :manage, :all
      # else
      #   can :read, :all
      # end

      if user.role? :admin
        can :manage, :all
      elsif user.role? :instructor
        can :read, Instructor
        can :update, Instructor do |instructor|
          instructor.id == user.instructor_id
        end
        can :read, Location
        # may have to restrict what other instructors can be seen
        can :read, Curriculum
        # may have to restrict which camps an instructor can see
        can :read, Camp
        # instructor can only view own camp's students details
        can :read, Student do |student|
          # all the camp ids an instructor teaches
          instructor_camp_ids = CampInstructor.all.where(instructor_id: user.instructor_id).map { |e| e.camp_id }
          # all the camp ids a student is registered for
          student_camp_ids = Registration.all.where(student_id: student.id).map { |b| b.camp_id }
          # check if there are any overlapping camps that a student takes and an instructor teaches
          !(instructor_camp_ids & student_camp_ids).empty?
        end
      else
        # 
        can :read, Camp
      end


    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/bryanrite/cancancan/wiki/Defining-Abilities
  end
end
