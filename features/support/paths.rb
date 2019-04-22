
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'

    when /^the dash$/
      show_dash_path()

    when /^the admin view page$/
      admin_view_path()

    when /^the download page for (.+)$/
      case $1

      when "reports"
        report_download_path(Report.last.id)

      end

    when /^the index page for (.+)$/
      case $1

      when "applicants"
        applicants_path()

      when "applications"
        applications_path()

      when "admins"
        admins_path()

      when "bookings"
        bookings_path()

      when "calendar"
        calendar_path()

      when "coordinators"
        coordinators_path()

      when "mercyhomes"
        mercyhomes_path()

      when "mercyrooms"
        mercyrooms_path()

      end

    when  /^the show page for (.*)$/i
      case $1
      when "applicants"
        applicant_path(Applicant.last)
      when "applications"
        application_path(Application.last)
      when "admins"
        admin_path(Admin.last)
      when "bookings"
        booking_path(Booking.last)
      when "coordinators"
        coordinator_path(Coordinator.last)
      when "mercyhomes"
        mercyhome_path(Mercyhome.last)
      when "mercyrooms"
        mercyroom_path(Mercyroom.last)
      end

    when  /^the edit page for (.*)$/i
      case $1
      when "applicants"
        edit_applicant_path(Applicant.last)
      when "applications"
        edit_application_path(Application.last)
      when "admins"
        edit_admin_path(Admin.last)
      when "bookings"
        edit_booking_path(Booking.last)
      when "coordinators"
        edit_coordinator_path(Coordinator.last)
      when "mercyhomes"
        edit_mercyhome_path(Mercyhome.last)
      when "mercyrooms"
        edit_mercyroom_path(Mercyroom.last)
      end

    when /^the new page for (.*)$/i
      case $1
      when "applicants"
        new_applicant_path()
      when "applications"
        @applicant = Applicant.new(AName: 'John Doe', AEmail: 'JohnDoe@example.com')
        @applicant.save
        applicants_id = @applicant.id
        new_application_path(applicants_id: applicants_id)
      when "admins"
        new_admin_path()
      when "bookings"
        new_booking_path()
      when "coordinators"
        new_coordinator_path()
      when "mercyhomes"
        new_mercyhome_path()
      when "mercyrooms"
        new_mercyroom_path()
      when "reports"
        new_report_path()
      end

    when /^the renew page for (.+)$/
      case $1
      when /^booking(?:| "(.+)")$/
        case $1
        when " "
          app_booking_path(id: '')
        else
          app_booking_path(id: $1)
        end
      end


    when /^the page for (.+)$/
      case $1
      when "success"
        success_path()
      end

    when /^the details page for (.*)$/i
      case $1
      when "booking"
        @booking = Booking.last
        booking_path(@booking)
      end

      # @movie = Movie.where(title: $1).limit(1)
      # @id = ''
      # @movie.each do |movie|
      #   @id = movie.id
      # end
      # movie_path(@id)

    when  /^the Similar Movies page for "(.*)"$/i
      @movie = Movie.where(title: $1).limit(1)
      @id = ''
      @movie.each do |movie|
        @id = movie.id
      end
      similar_movies_path(@id)


    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
