class ArtistsController < ApplicationController
  
  
  # GET /artists
  # GET /artists.xml
  def index
    @artists = Artist.all(:order => "name ASC")
    @pageTitle = "Artists"
    @section = "Artist"
  end
  
  
  # GET /artists/1
  # GET /artists/1.xml
  def show
    @artist = Artist.find_by_urlname(params[:id])
    @pageTitle = "#{@artist.name}"
    @section = "Artist"
    respond_to do |format|
      format.html # artist.html.erb
      format.xml  { render :xml => @artist }
    end
  end
  

  # GET /artists/new
  # GET /artists/new.xml
  def new
    @artist = Artist.new
    @nav = "artists"

    respond_to do |format|
      format.html { render :layout => 'admin' }
      format.xml  { render :xml => @artist }
    end
  end

  # GET /artists/1/edit
  def edit
    @artist = Artist.find_by_urlname(params[:id])    
    @nav = "artists"    
    respond_to do |format|
      format.html { render :layout => 'admin' }
      format.xml  { render :xml => @artist }
    end  

  end

  # POST /artists
  # POST /artists.xml
  def create
    @artist = Artist.new(params[:artist])

    respond_to do |format|
      if @artist.save
        flash[:notice] = 'Artist was successfully created.'
        format.html { redirect_to(:controller=>:admin, :action=>:artist_list) }
        format.xml  { render :xml => @artist, :status => :created, :location => @artist }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @artist.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /artists/1
  # PUT /artists/1.xml
  def update
    @artist = Artist.find_by_urlname(params[:id])

    respond_to do |format|
      if @artist.update_attributes(params[:artist])
        flash[:notice] = 'Artist was successfully updated.'
        format.html { redirect_to(:controller=>:admin, :action=>:artist_list) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @artist.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /artists/1
  # DELETE /artists/1.xml
  def destroy
    @artist = Artist.find_by_urlname(params[:id])
    @artist.destroy

    respond_to do |format|
      format.html { redirect_to(:controller=>:admin, :action=>:artist_list) }
      format.xml  { head :ok }
    end
  end


end