class ExhibitionsController < ApplicationController
  
  
  # GET /exhibitions
  # GET /exhibitions.xml
  def index
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
  # GET /exhibitions/1
  # GET /exhibitions/1.xml
  def show
    @exhibition = Exhibition.find(params[:id])

    respond_to do |format|
      format.html # exhibition.html.erb
      format.xml  { render :xml => @exhibition }
    end
  end

  # GET /exhibitions/new
  # GET /exhibitions/new.xml
  def new
    @exhibition = Exhibition.new
    @artists = Artist.all 
    respond_to do |format|
      format.html { render :layout=>'admin' }
      format.xml  { render :xml => @exhibition }
    end
  end

  # GET /exhibitions/1/edit
  def edit
    @exhibition = Exhibition.find(params[:id])
    @artists = Artist.all
    respond_to do |format|
      format.html { render :layout=>'admin' }
      format.xml  { render :xml => @exhibition }
    end
  end

  # POST /exhibitions
  # POST /exhibitions.xml
  def create
    @exhibition = Exhibition.new(params[:exhibition])

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
    @exhibition = Exhibition.find(params[:id])

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
    @exhibition = Exhibition.find(params[:id])
    @exhibition.destroy

    respond_to do |format|
      format.html { redirect_to(:controller=>:admin, :action => :exhibition_list) }
      format.xml  { head :ok }
    end
  end


end