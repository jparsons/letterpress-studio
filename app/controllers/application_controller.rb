# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Authentication

  def redirect_to_index(msg = nil)
    flash[:notice] = msg if msg
    redirect_to(:action => 'index')
  end
  
  private

  def authorize
    unless Author.find_by_id(session[:author_id])
      flash[:notice] = "Please log in"
      redirect_to(:controller => "login", :action => "login")
    end
  end

end

class Fixnum
 #return month name
 def name_of_month
  month_name=[nil, 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
  month_name[self.to_i]
 end

 #return day name
 def name_of_day
  day_name=[nil, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
  day_name[self.to_i]
 end

end

class DateTime
 #convert DateTime to Time
 def to_time
   Time.mktime(year, mon, day, hour, min, sec)
 end
end

class Time
 #convert Time to DateTime
 def to_datetime
   DateTime.civil(year, mon, day, hour, min, sec)
 end
end

class String
 #for converting a day number to a two character string
 def two_char
  if self.to_i < 10
   char_date = "0" + self.to_i.to_s
  else char_date = self.to_s
  end
 end
end
