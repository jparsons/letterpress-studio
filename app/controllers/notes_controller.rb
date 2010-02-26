class NotesController < ApplicationController
  
  
  # GET /notes
  # GET /notes.xml
  def index
    @notes = Note.paginate(:page=>params[:page], :per_page => 4, :conditions => ["is_active = ?", true], :order => 'created_at DESC')
    @pageTitle = "News"
    @section = "Notes"
    @links = "yes"  
  end
  # GET /notes/1
  # GET /notes/1.xml
  def show
    @note = Note.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @note }
    end
  end
  
  def tag_list
    @tags = Tag.all
    @pageTitle = "Sort Notes By Tag"
    @section = "Notes"
    @recent = "yes"
  end
  
  def find_by_urlname
    @note = Note.find_by_date_and_urlname(params[:year], params[:month], params[:name]) 
    if @note.nil?
      redirect_to root_url
    else
      render :action=>:show
    end
  end
  
  def find_by_tag_name
    @notes = Note.tagged_with(params[:name]).active
    @pageTitle = "Tagged with #{params[:name]}"
    @section = "notes"
    @recent = "yes"
    if @notes.blank?
      #TODO add flash message
      redirect_to root_url
    else
      render :action=>:index
    end  
  end
  
  def list_by_date 
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
      render :action => 'index'
    end  
  
  
  end
  
  def list_by_year
  
  
  end

  # GET /notes/new
  # GET /notes/new.xml
  def new
    @note = Note.new
    @tags = Tag.find(:all, :order => "name")
    @nav = "notes"
    
    respond_to do |format|
      format.html { render :layout => 'admin' }
      format.xml  { render :xml => @note }
    end
  end

  # GET /notes/1/edit
  def edit
    @note = Note.find(params[:id])
    @tags = Tag.find(:all, :order => "name")
    @nav = "notes"
    
    respond_to do |format|
      format.html { render :layout => 'admin' }
      format.xml  { render :xml => @note }
    end    
  end

  # POST /notes
  # POST /notes.xml
  def create
    @note = Note.new(params[:note])

    respond_to do |format|
      if @note.save
        flash[:notice] = 'Note was successfully created.'
        format.html { redirect_to(@note) }
        format.xml  { render :xml => @note, :status => :created, :location => @note }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @note.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /notes/1
  # PUT /notes/1.xml
  def update
    @note = Note.find(params[:id])

    respond_to do |format|
      if @note.update_attributes(params[:note])
        flash[:notice] = 'Note was successfully updated.'
        format.html { redirect_to(@note) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @note.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.xml
  def destroy
    @note = Note.find(params[:id])
    @note.destroy

    respond_to do |format|
      format.html { redirect_to(:controller=>:admin, :action=>"note_list") }
      format.xml  { head :ok }
    end
  end


end