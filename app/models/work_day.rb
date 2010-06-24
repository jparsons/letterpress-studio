class WorkDay < ActiveRecord::Base
  def display_name
    WEEKDAYS.index(day_number)
  end
  
  def display_start_hour
    HOURS.index(start_hour)
  end
  
  def display_end_hour
    HOURS.index(end_hour)
  end
end
