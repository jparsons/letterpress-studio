class IconsController < ApplicationController
  # GET /icons
  # GET /icons.xml
  
  before_filter :find_static, :only=>[:new, :edit, :create]
  def index
    @icons = Icon.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @icons }
    end
  end

  # GET /icons/1
  # GET /icons/1.xml
  def show
    @icon = Icon.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @icon }
    end
  end

  # GET /icons/new
  # GET /icons/new.xml
  def new
    @icon = Icon.new

    respond_to do |format|
      format.html { render :layout => 'admin'}
      format.xml  { render :xml => @icon }
    end
  end

  # GET /icons/1/edit
  def edit
    @icon = Icon.find(params[:id])
    respond_to do |format|
      format.html { render :layout => 'admin'}
      format.xml  { render :xml => @icon }
    end    
  end

  # POST /icons
  # POST /icons.xml
  def create
    @icon = Icon.new(params[:icon])
    @icon.static = @static
    respond_to do |format|
      if @icon.save
        flash[:notice] = 'Icon was successfully created.'
        format.html { redirect_to(:controller=>:admin, :action=>:icon_list) }
        format.xml  { render :xml => @icon, :status => :created, :location => @icon }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @icon.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /icons/1
  # PUT /icons/1.xml
  def update
    @icon = Icon.find(params[:id])

    respond_to do |format|
      if @icon.update_attributes(params[:icon])
        flash[:notice] = 'Icon was successfully updated.'
        format.html { redirect_to(:controller=>:admin, :action=>:icon_list) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @icon.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /icons/1
  # DELETE /icons/1.xml
  def destroy
    @icon = Icon.find(params[:id])
    @icon.destroy

    respond_to do |format|
      format.html { redirect_to(:controller=>:admin, :action=>:icon_deletes) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def find_static

    @static = Static.find_by_urlname(params[:static_id])

    rescue
      redirect_to :controller => :admin, :action => :icon_list
  end
end
