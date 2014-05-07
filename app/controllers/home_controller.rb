class HomeController < ApplicationController
  def index
  	if !current_user.nil?
      # this provides the data needed for the instructor dashboard
  		@instructor = current_user.instructor
      @upcoming_camps = @instructor.camps.upcoming.chronological.map { |e| e.name.to_s + ' on ' + humanize_date(e.start_date) }
      @registration_count = @instructor.camps.upcoming.chronological.map { |camp| Registration.where("camp_id = ?", camp.id).count  }
  	  @camp_to_registration_instructor = Hash[@upcoming_camps.zip @registration_count]
      # this provides data needed for the admin dashboard
      # For Pie Graph
      @camps = Camp.all.alphabetical
      # For Bar Graph
      @instructors = CampInstructor.all.map { |e| e.instructor.proper_name }
      @camps_taught = CampInstructor.all.map { |r| CampInstructor.where('instructor_id = ?', r.instructor_id).count }
      @camps_to_instructor = Hash[@instructors.zip @camps_taught]
      # Registrations per camp
      @upcoming_camps_admin = Camp.all.upcoming.chronological.map { |e| e.name.to_s + ' on ' + humanize_date(e.start_date)  }
      @registration_count_admin = Camp.all.upcoming.chronological.map { |camp| Registration.where("camp_id = ?", camp.id).count  }
      @camp_to_registration_admin = Hash[@upcoming_camps_admin.zip @registration_count_admin]
      # find total revenue and balances for camps in a year
      @camp_names = Camp.all.chronological.map { |e| e.name.to_s + ' on ' + humanize_date(e.start_date) }
      @camp_revenues = Camp.all.chronological.map { |camp| Registration.where("camp_id = ?", camp.id).paid.count * camp.cost + Registration.where('camp_id = ?', camp.id).deposit_only.count * 50}
      @camp_to_revenues = Hash[@camp_names.zip @camp_revenues]
      # find the accounts receivable for camps in a year
      @camp_accounts_receivable = Camp.all.chronological.map { |camp| Registration.where('camp_id = ?', camp.id).deposit_only.count * (camp.cost - 50 ) }
      @camp_to_ar = Hash[@camp_names.zip @camp_accounts_receivable]
    end
  end

  def about
  end

  def contact
  end

  def privacy
  end

  def reports
    if !current_user.nil?
      # find total revenue and balances for camps in a year
      @camp_names = Camp.all.chronological.map { |e| e.name.to_s + ' on ' + humanize_date(e.start_date) }
      @camp_revenues = Camp.all.chronological.map { |camp| Registration.where("camp_id = ?", camp.id).paid.count * camp.cost + Registration.where('camp_id = ?', camp.id).deposit_only.count * 50}
      @camp_to_revenues = Hash[@camp_names.zip @camp_revenues]
      # find the accounts receivable for camps in a year
      @camp_accounts_receivable = Camp.all.chronological.map { |camp| Registration.where('camp_id = ?', camp.id).deposit_only.count * (camp.cost - 50 ) }
      @camp_to_ar = Hash[@camp_names.zip @camp_accounts_receivable]
      # find total revenue for a family in a year

      # find the accounts receivable for a family in a year
    end
  end
  
end
