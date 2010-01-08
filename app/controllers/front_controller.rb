class FrontController < ApplicationController
  def index
    @notes = Note.paginate(:page=>params[:page], :per_page => 4, :conditions => 'is_active = 1', :order => 'created_at DESC')
    @pageTitle = "News"
    @section = "Notes"
    @links = "yes"
  end

  def note_find_by_urlname
    @note = Note.find_by_date_and_urlname(params[:year], params[:month], params[:name]) 
    @pageTitle = "#{@note.name}"
    @section = "Notes"
    @next = Note.find_next(@note)
    @previous = Note.find_previous(@note)
    @previous_next_links = "yes"
    @recent = "yes"
    rescue
    logger.error("Attempt to access invalid Note #{params[:name]}")
    redirect_to_index('Invalid Note')
  end

  def note_list_by_date
    @section = "Notes"
    @recent = "yes"
    if params["month"]
      lower_date = Date.new(params["year"].to_i,params["month"].to_i,1)
      date = Date.new(params["year"].to_i,params["month"].to_i,1)
      @title = "Posted in #{date.month.name_of_month} #{date.year}"
      @notes = Note.find(:all,:conditions => "created_at >= '#{lower_date}' AND created_at < '#{(lower_date >> 1)-1}'",:order => "created_at desc")
      @pageTitle = "#{date.month.name_of_month} #{date.year}"
    elsif params["year"]
      lower_date = Date.new(params["year"].to_i,1,1)
      date = Date.new(params["year"].to_i,1,1)
      @title = "Posted in #{date.year}"
      @notes = Note.find(:all, :conditions => "created_at >= '#{lower_date}' AND created_at < '#{lower_date.year+1}'",:order => "created_at desc")
      @pageTitle = "#{date.year}"
    else
      @title = "Archive"
      @notes = Note.find(:all, :order => "created_at desc")
    end
    if @notes.empty?
      redirect_to_index("No notes in that time frame")
    else
      render :action => 'note_list'
    end
  end
  
  def tag_find_by_urlname
    @tag = Tag.find_by_urlname(params[:name])
    @notes = Note.find_by_tag(params[:name], :conditions => 'is_active = 1', :order => "created_at desc")
    @pageTitle = "Tagged with #{@tag.name}"
    @section = "notes"
    @recent = "yes"
    if @notes.length < 1
      redirect_to_index('No notes with that tag')
    end
  rescue
    logger.error("Attempt to access invalid Tag #{params[:name]}")
    redirect_to_index('Invalid Tag')
  end
  
  def tag_list
    @tags = Tag.find_all_tags_with_note_counters
    @pageTitle = "Sort Notes By Tag"
    @section = "Notes"
    @recent = "yes"
  end
  
  def note_feed # Displays the XML Feed for recent listings
    @note = Note.find_for_feed
    @headers["Content-Type"] = "application/xml; charset=utf-8"
    render :layout => false
  end
  
  # Exhibitions
  def exhibition_find_by_urlname
    @exhibition = Exhibition.find_by_urlname(params[:name])
    @artists = @exhibition.artists.find(:all, :conditions => 'is_active = 1', :order => "created_at desc")
    @pageTitle = "#{@exhibition.name}"
    @section = "Exhibitions"
  rescue
    logger.error("Attempt to access invalid Exhibition #{params[:name]}")
    redirect_to_index('Invalid Exhibition')
  end
  
  def exhibition_list
    @exhibitions = Exhibition.find(:all, :conditions => 'is_active = 1', :order => "event_start_at DESC")
    @exhibitions_future = Exhibition.all_future_shows
    @exhibitions_past = Exhibition.all_past_shows
    @exhibitions_current = Exhibition.all_current_shows
    @exhibitions_current_count = Exhibition.count(:all, :conditions => ['is_active = 1 and event_start_at < ? and event_finish_at > ?',Time.now, Time.now])
    @exhibitions_future_count = Exhibition.count(:all, :conditions => ['is_active = 1 and event_start_at > ?', Time.now])
    @exhibitions_past_count = Exhibition.count(:all, :conditions => ['is_active = 1 and event_start_at < ?', Time.now])
    @pageTitle = "Shows"
    @section = "Exhibitions"
  end
  
  # Products
  def product_find_by_urlname
    @product = Product.find_by_urlname(params[:name])
    @pageTitle = "#{@product.name}"
    @section = "Products"
  rescue
    logger.error("Attempt to access invalid Good #{params[:name]}")
    redirect_to_index('Invalid Good')
  end
  
  def product_list
    @products = Product.find(:all, :conditions => 'is_active = 1', :order => "id DESC")
    @pageTitle = "Goods"
    @section = "Product"
  end
  
  # Static
  def static_find_by_urlname
    @static = Static.find_by_urlname(params[:name])
    @pageTitle = "#{@static.name}"
    @section = "Static"
    if @static.name == 'Contact'
      @map_layout = 'yes'
      @mailing_list = 'yes'
      @place_name = "The Arm"
      @this_address = "281 North 7th, Brooklyn, NY"
        results = Geocoding::get("#{@this_address}")
                if results.status == Geocoding::GEO_SUCCESS
                        coord = results[0].latlon
                        @map = GMap.new("map_div")
                        @map.control_init(:large_map => false,:map_type => true,:small_zoom => true)
                        @map.center_zoom_init(coord,16)
                        #@map.set_map_type_init(GMapType::G_HYBRID_MAP)
                        @map.overlay_init(GMarker.new(coord,:info_window => "<b>#{@place_name}</b><br />#{@this_address}"))
                end
    end
  rescue
    logger.error("Attempt to access invalid Information Page #{params[:name]}")
    redirect_to_index('Invalid Information Page')
  end
  
  def static_list
    @statics = Static.find(:all, :order => "name ASC")
    @pageTitle = "Information"
    @section = "Static"
  end

  # Artist
  def artist_find_by_urlname
    @artist = Artist.find_by_urlname(params[:name])
    @pageTitle = "#{@artist.name}"
    @section = "Artist"
  rescue
    logger.error("Attempt to access invalid Artist #{params[:name]}")
    redirect_to_index('Invalid Artist')
  end
  
  def artist_list
    @artists = Artist.find(:all, :order => "name ASC")
    @pageTitle = "Artists"
    @section = "Artist"
  end
  
end
