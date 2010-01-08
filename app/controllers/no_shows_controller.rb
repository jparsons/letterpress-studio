class NoShowsController < ApplicationController
  # GET /no_shows
  # GET /no_shows.xml
  def index
    @no_shows = NoShow.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @no_shows }
    end
  end

  # GET /no_shows/1
  # GET /no_shows/1.xml
  def show
    @no_show = NoShow.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @no_show }
    end
  end

  # GET /no_shows/new
  # GET /no_shows/new.xml
  def new
    @no_show = NoShow.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @no_show }
    end
  end

  # GET /no_shows/1/edit
  def edit
    @no_show = NoShow.find(params[:id])
  end

  # POST /no_shows
  # POST /no_shows.xml
  def create
    @no_show = NoShow.new(params[:no_show])

    respond_to do |format|
      if @no_show.save
        flash[:notice] = 'NoShow was successfully created.'
        format.html { redirect_to(@no_show) }
        format.xml  { render :xml => @no_show, :status => :created, :location => @no_show }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @no_show.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /no_shows/1
  # PUT /no_shows/1.xml
  def update
    @no_show = NoShow.find(params[:id])

    respond_to do |format|
      if @no_show.update_attributes(params[:no_show])
        flash[:notice] = 'NoShow was successfully updated.'
        format.html { redirect_to(@no_show) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @no_show.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /no_shows/1
  # DELETE /no_shows/1.xml
  def destroy
    @no_show = NoShow.find(params[:id])
    @no_show.destroy

    respond_to do |format|
      format.html { redirect_to(no_shows_url) }
      format.xml  { head :ok }
    end
  end
end
