class StaticsController < ApplicationController
  
  
  # GET /statics
  # GET /statics.xml
  def index
    @statics = Static.all(:order => "name ASC")
    @pageTitle = "Information Pages"
    @section = "Static"
  end
  # GET /statics/1
  # GET /statics/1.xml
  def show
    @static = Static.find_by_urlname(params[:id])
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
    redirect_to_index('Invalid Information Page')  end

  # GET /statics/new
  # GET /statics/new.xml
  def new
    @static = Static.new
    @nav = "information"
    respond_to do |format|
      format.html { render :layout => 'admin' }
      format.xml  { render :xml => @static }
    end
  end

  # GET /statics/1/edit
  def edit
    @static = Static.find_by_urlname(params[:id])
    @nav = "information"
    respond_to do |format|
      format.html { render :layout => 'admin' }
      format.xml  { render :xml => @static }
    end    
  end

  # POST /statics
  # POST /statics.xml
  def create
    @static = Static.new(params[:static])
 
    respond_to do |format|
      if @static.save
        flash[:notice] = 'Static was successfully created.'
        format.html { redirect_to(:controller => :admin, :action => :static_list) }
        format.xml  { render :xml => @static, :status => :created, :location => @static }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @static.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /statics/1
  # PUT /statics/1.xml
  def update
    @static = Static.find_by_urlname(params[:id])

    respond_to do |format|
      if @static.update_attributes(params[:static])
        flash[:notice] = 'Static was successfully updated.'
        format.html { redirect_to(:controller => :admin, :action => :static_list) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @static.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /statics/1
  # DELETE /statics/1.xml
  def destroy
    @static = Static.find_by_urlname(params[:id])
    @static.destroy

    respond_to do |format|
      format.html { redirect_to(:controller => :admin, :action => :static_list) }
      format.xml  { head :ok }
    end
  end


end