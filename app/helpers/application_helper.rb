# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def check_browser
		@bad_browser = false
		agent = @request.env['HTTP_USER_AGENT']
		if (agent =~ /windows/i) and (agent =~ /msie/i)
		  @bad_browser = true
			if (agent =~ /opera/i)
				@is_opera = true
			end
		end
	end
	
	def recent_notes
      notes = Note.find(:all, :limit => 7, :order => 'created_at DESC')
      notes.each { |note| yield(note) }
  end
  
  def current_show
      exhibitions = Exhibition.find(:all, :conditions => ['is_active = 1 and event_start_at < ? and event_finish_at > ?',Time.now, Time.now])
      exhibition.each { |exhibition| yield(exhibition) }
  end
	
	def all_static
      statics = Static.find(:all, :order => 'id DESC')
      statics.each { |static| yield(static) }
  end
	
	def random_image
    image_files = %w( .jpg .gif .png )
    files = Dir.entries(
          "#{RAILS_ROOT}/public/rotate" 
      ).delete_if { |x| !image_files.index(x[-4,4]) }
    files[rand(files.length)]
  end
  def random_bgd
    image_files = %w( .jpg .gif .png )
    files = Dir.entries(
          "#{RAILS_ROOT}/public/bgd" 
      ).delete_if { |x| !image_files.index(x[-4,4]) }
    files[rand(files.length)]
  end
  
  def available_days
    @workdays = WorkDay.all 
    @workdays.map{|d| d.display_name}.join(",").to_json
  end
  
  def holidays
    @holidays = Holiday.all
    @holidays.map{|h| [h.date.month, h.date.day, h.date.year] }.to_json
  end
	
end
