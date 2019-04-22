class CalendarController < AuthenticationController

  # Only admins can see the calendar
  before_action :is_admin

  def calendar

    month = DateTime.current.month
    year = DateTime.current.year

    if params.has_key?('commit') && params['commit'] == 'Today'
      session['start_date'] = Date.today
    end

    if !session.has_key?('start_date')
      session['start_date'] = Date.today
    end

    if params.has_key?('start_date') && !params['start_date'].empty?
      dt = Date.parse(params['start_date'].to_s)
      month = dt.month
      year = dt.year
    elsif !params.has_key?('commit')
      if params.has_key?('cal_month(2i)') && !params['cal_month(2i)'].empty?
       month = params['cal_month(2i)']
      end
      if params.has_key?('cal_year(1i)') && !params['cal_year(1i)'].empty?
          year = params['cal_year(1i)']
      end
    end


    sd = Date.new(year.to_i, month.to_i, 1)
    edm = month.to_i + 1
    edy = year.to_i
    if edm == 13
      edm = 1
      edy = edy + 1
    end
    ed = Date.new(edy, edm, 1)
    params[:start_date] = sd
    params[:end_date] = ed

    @bookings
    if (params.has_key?(:mhome) && !params[:mhome].nil? && !params[:mhome].empty?)
      @bookings =
          Booking
              .select('bookings.*, mercyrooms.mercyhomes_id, mercyrooms."RoomName", mercyhomes."HouseName", mercyhomes.color, applicants."AName"')
              .joins('INNER JOIN mercyrooms ON mercyrooms.id=bookings.mercyrooms_id')
              .joins('INNER JOIN mercyhomes ON mercyhomes.id=mercyrooms.mercyhomes_id')
              .joins('INNER JOIN applicants ON applicants.id=bookings.applicants_id')
              .where(ActiveRecord::Base::sanitize_sql("'#{sd}' <  \"EndDate\" and '#{ed}' > \"StartDate\" and mercyhomes.id=#{params[:mhome]}"))

    else
      @bookings =
          Booking
              .select('bookings.*, mercyrooms.mercyhomes_id, mercyrooms."RoomName", mercyhomes."HouseName", mercyhomes.color, applicants."AName"')
              .joins(ActiveRecord::Base::sanitize_sql('INNER JOIN mercyrooms ON mercyrooms.id=bookings.mercyrooms_id'))
              .joins(ActiveRecord::Base::sanitize_sql('INNER JOIN mercyhomes ON mercyhomes.id=mercyrooms.mercyhomes_id'))
              .joins(ActiveRecord::Base::sanitize_sql('INNER JOIN applicants ON applicants.id=bookings.applicants_id'))
              .where('? <  "EndDate" and ? > "StartDate"', sd, ed)

    end


    homeHash = Hash.new
    @bookings.each do |booking|
      if homeHash.has_key?(booking.mercyhomes_id)
        booking.color = homeHash[booking.mercyhomes_id]
      else
        booking.color = gen_random_color
        homeHash[booking.mercyhomes_id] = booking.color
      end
    end

    @mercyhomes = get_mercyhomes

  end

  def get_mercyhomes
    return Mercyhome.get_all_homes
  end

  def gen_random_color

    colors = [255, 255, 255]

    numDiminished = rand(100) + 1
    dimColor1 = rand(3)
    dimColor2 = dimColor1
    while dimColor2 == dimColor1
      dimColor2 = rand(3)
    end

    if numDiminished < 5
    elsif numDiminished < 15
      colors[dimColor1] = (rand(150) + 105)
    else
      colors[dimColor1] = (rand(150) + 105)
      colors[dimColor2] = (rand(150) + 105)
    end


    color = ''
    initColor = colors

    initColor.each do |component|
      hex = component.to_s(16)
      # if component < 16
      #   color << "0#{hex}"
      # else
        color << hex
      # end
    end
    color
  end

end
