class ExhibitionsController < ApplicationController
  
  
  # GET /exhibitions
  # GET /exhibitions.xml
  def index
    @exhibitions = Exhibition.active
    @exhibitions_future = Exhibition.future
    @exhibitions_past = Exhibition.past
    @exhibitions_current = Exhibition.current
    @exhibitions_current_count = Exhibition.current.size
    @exhibitions_future_count = Exhibition.future.size
    @exhibitions_past_count = Exhibition.past.size
    @pageTitle = "Shows"
    @section = "Exhibitions" 
  end
  # GET /exhibitions/1
  # GET /exhibitions/1.xml
  def show
    @exhibition = Exhibition.find_by_urlname(params[:id])
    @artists = @exhibition.artists.find(:all, :conditions => 'is_active = 1', :order => "created_at desc")
    @pageTitle = "#{@exhibition.name}"
    @section = "Exhibitions"

    respond_to do |format|
      format.html # exhibition.html.erb
      format.xml  { render :xml => @exhibition }
    end
    
  #rescue
  #  logger.error("Attempt to access invalid Exhibition #{params[:id]}")
  #  redirect_to_index('Invalid Exhibition')    
  end
  
  def find_by_urlname 
  
  end

  # GET /exhibitions/new
  # GET /exhibitions/new.xml
  def new
    @exhibition = Exhibition.new
    @artists = Artist.all 
    @nav = "exhibitions"
    respond_to do |format|
      format.html { render :layout=>'admin' }
      format.xml  { render :xml => @exhibition }
    end
  end

  # GET /exhibitions/1/edit
  def edit
    @exhibition = Exhibition.find_by_urlname(params[:id])
    @artists = Artist.all
    @nav = "exhibitions"

    respond_to do |format|
      format.html { render :layout=>'admin' }
      format.xml  { render :xml => @exhibition }
    end
  end

  # POST /exhibitions
  # POST /exhibitions.xml
  def create
    @exhibition = Exhibition.new(params[:exhibition])
    unless params[:artist_ids].blank? 
      @artists = Artist.find(params[:artist_ids])
      @exhibition.artists = @artists
    end
    respond_to do |format|
      if @exhibition.save
        flash[:notice] = 'Exhibition was successfully created.'
        format.html { redirect_to(:controller=>:admin, :action=>:exhibition_list) }
        format.xml  { render :xml => @exhibition, :status => :created, :location => @exhibition }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @exhibition.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /exhibitions/1
  # PUT /exhibitions/1.xml
  def update
    @exhibition = Exhibition.find_by_urlname(params[:id])
    if params[:artist_ids].blank?
      @exhibition.artists.clear
    else
      @artists = Artist.find(params[:artist_ids]) 
      @exhibition.artists = @artists
    end
    respond_to do |format|
      if @exhibition.update_attributes(params[:exhibition])
        flash[:notice] = 'Exhibition was successfully updated.'
        format.html { redirect_to(:controller=>:admin, :action=>:exhibition_list) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @exhibition.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /exhibitions/1
  # DELETE /exhibitions/1.xml
  def destroy
    @exhibition = Exhibition.find_by_urlname(params[:id])
    @exhibition.destroy

    respond_to do |format|
      format.html { redirect_to(:controller=>:admin, :action => :exhibition_list) }
      format.xml  { head :ok }
    end
  end


end