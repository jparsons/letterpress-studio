class AdminController < ApplicationController
  before_filter :admin_required

  def index
    
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :note_list }

  def note_list
    @notes = Note.paginate(:page=>params[:page], :per_page => 10, :order => 'created_at DESC')
    @tags = Tag.find(:all, :order => "name ASC")
    @pageTitle = "All News Items"
    @nav = "notes"
  end

  def note_new
    @note = Note.new
    @tags = Tag.find(:all, :order => "name")
    @nav = "notes"
  end

  def note_create
    @note = Note.new(params[:note])
    @note.tag(params[:tag_input])
    @nav = "notes"
    if @note.save
      flash[:notice] = 'Note was successfully created.'
      redirect_to :action => 'note_list'
    else
      render :action => 'note_new'
    end
  end

  def note_edit
    @note = Note.find(params[:id])
    @pageTitle = "Editing: #{@note.name}"
    @tags = Tag.find(:all, :order => "name")
    @nav = "notes"
  end

  def note_update
    @note = Note.find(params[:id])
    @note.tag(params[:tag_input], :clear => true)
    @nav = "notes"
    if @note.update_attributes(params[:note])
      flash[:notice] = 'Note was successfully updated.'
      redirect_to :action => 'note_edit', :id => @note
    else
      render :action => 'note_edit'
    end
  end

  def note_destroy
    Note.find(params[:id]).destroy
    redirect_to :action => 'note_list'
  end
  
  
  #
  # Information
  #
  def static_list
    @statics = Static.paginate(:page=>params[:page], :per_page => 10, :order => 'id DESC')
    @pageTitle = "All statics"
    @nav = "information"
  end

  def static_new
    @static = Static.new
    @nav = "information"
  end

  def static_create
    @static = Static.new(params[:static])
    @nav = "information"
    if @static.save
      flash[:notice] = 'Information Page was successfully created.'
      redirect_to :action => 'static_list'
    else
      render :action => 'static_new'
    end
  end

  def static_edit
    @static = Static.find(params[:id])
    @pageTitle = "Editing: #{@static.name}"
    @nav = "information"
  end

  def static_update
    @static = Static.find(params[:id])
    @nav = "information"
    if @static.update_attributes(params[:static])
      flash[:notice] = 'Information Page was successfully updated.'
      redirect_to :action => 'static_edit', :id => @static
    else
      render :action => 'static_edit'
    end
  end

  def static_destroy
    Static.find(params[:id]).destroy
    redirect_to :action => 'static_list'
  end
  
  
  #
  # Products
  #
  def product_list
  @products = Product.paginate(:page=>params[:page],:per_page => 10, :order => 'id DESC')
  @pageTitle = "All products"
  @nav = "products"
  end

  def product_new
  @product = Product.new
  @nav = "products"
  end

  def product_create
  @product = Product.new(params[:product])
  @nav = "information"
  if @product.save
    flash[:notice] = 'Product was successfully created.'
    redirect_to :action => 'product_list'
  else
    render :action => 'product_new'
  end
  end

  def product_edit
  @product = Product.find(params[:id])
  @pageTitle = "Editing: #{@product.name}"
  @nav = "products"
  end

  def product_update
  @product = Product.find(params[:id])
  @nav = "information"
  if @product.update_attributes(params[:product])
    flash[:notice] = 'Product was successfully updated.'
    redirect_to :action => 'product_edit', :id => @product
  else
    render :action => 'product_edit'
  end
  end

  def product_destroy
  Product.find(params[:id]).destroy
  redirect_to :action => 'product_list'
  end
  
  #
  # Exhibitions
  #
  def exhibition_list
  @exhibitions = Exhibition.paginate(:page=>params[:page], :per_page => 10, :order => 'id DESC')
  @pageTitle = "All exhibitions"
  @nav = "exhibitions"
  end

  def exhibition_new
  @exhibition = Exhibition.new
  @artists = Artist.find(:all, :order => "name")
  @nav = "exhibitions"
  end

  def exhibition_create
  @exhibition = Exhibition.new(params[:exhibition])
  @exhibition.artists = Artist.find(params[:artist_ids]) if params[:artist_ids]
  @nav = "information"
  if @exhibition.save
    flash[:notice] = 'Exhibition was successfully created.'
    redirect_to :action => 'exhibition_list'
  else
    render :action => 'exhibition_new'
  end
  end

  def exhibition_edit
  @exhibition = Exhibition.find(params[:id])
  @artists = Artist.find(:all, :order => "name")
  @pageTitle = "Editing: #{@exhibition.name}"
  @nav = "exhibitions"
  end

  def exhibition_update
  @exhibition = Exhibition.find(params[:id])
  @exhibition.artists = Artist.find(params[:artist_ids]) if params[:artist_ids]
  @nav = "exhibitions"
  if @exhibition.update_attributes(params[:exhibition])
    flash[:notice] = 'Exhibition was successfully updated.'
    redirect_to :action => 'exhibition_edit', :id => @exhibition
  else
    render :action => 'exhibition_edit'
  end
  end

  def exhibition_destroy
  Exhibition.find(params[:id]).destroy
  redirect_to :action => 'exhibition_list'
  end
  
  # Exhibition Photos
  # photos - more images for exhibitions!
  
  def photo_list
    @exhibitions = Exhibition.find(:all, :order => 'id desc')
    @nav = "exhibitions"
  end

  def photo_new
    begin
      @exhibition = Exhibition.find(params[:id])
    rescue
      flash[:notice] = "You must first choose an exhibition before adding images"
      redirect_to :action => 'photo_list'
    end
    @photo = Photo.new
    @nav = "exhibitions"
  end

  def photo_create
    @exhibition = Exhibition.find(params[:photo][:exhibition_id])
    @photo = Photo.new(params[:photo])
    if @photo.save
      flash[:notice] = "Added image"
    else
      flash[:notice] = "There was a problemo. The image wasn't saved. You probably forgot to add an image."
    end
    redirect_to :action => "photo_new", :id => @exhibition
  end

  def photo_destroy
    Photo.find(params[:id]).destroy
    flash[:notice] = "Image #{params[:id]} deleted."
    redirect_to :action => 'photo_list'
  end
  
  def exhibition_photo_sort
     @exhibition = Exhibition.find(params[:id])
     @nav = "exhibitions"
   end                                            
   
   def photo_sort
     @exhibition = Exhibition.find(params[:id])
     @exhibition.photos.each do |photo|
       photo.position = params['photo-list'].index(photo.id.to_s) + 1
       photo.save
     end
     render :nothing => true
   end
   
   def photo_edit
   @photo = Photo.find(params[:id])
   @pageTitle = "Editing: #{@photo.name}"
   @nav = "exhibitions"
   end

   def photo_update
   @photo = Photo.find(params[:id])
   @nav = "exhibitions"
     if @photo.update_attributes(params[:photo])
       flash[:notice] = 'Photo was successfully updated.'
       redirect_to :action => 'photo_edit', :id => @photo
     else
       render :action => 'photo_edit'
     end
   end
  
  #
  # Artists
  #
  def artist_list
  @artists = Artist.paginate(:page=>params[:page], :per_page => 10, :order => 'id DESC')
  @pageTitle = "All artists"
  @nav = "artists"
  end

  def artist_new
  @artist = Artist.new
  @nav = "artists"
  end

  def artist_create
  @artist = Artist.new(params[:artist])
  @nav = "information"
  if @artist.save
    flash[:notice] = 'Artist was successfully created.'
    redirect_to :action => 'artist_list'
  else
    render :action => 'artist_new'
  end
  end

  def artist_edit
  @artist = Artist.find(params[:id])
  @pageTitle = "Editing: #{@artist.name}"
  @nav = "artists"
  end

  def artist_update
  @artist = Artist.find(params[:id])
  @nav = "information"
  if @artist.update_attributes(params[:artist])
    flash[:notice] = 'Artist was successfully updated.'
    redirect_to :action => 'artist_edit', :id => @artist
  else
    render :action => 'artist_edit'
  end
  end

  def artist_destroy
  Artist.find(params[:id]).destroy
  redirect_to :action => 'artist_list'
  end
  
  # Artist Pictures

  def picture_list
    @artists = Artist.find(:all, :order => 'id desc')
    @nav = "artists"
  end

  def picture_new
    begin
      @artist = Artist.find(params[:id])
    rescue
      flash[:notice] = "You must first choose an artist before adding images"
      redirect_to :action => 'picture_list'
    end
    @picture = Picture.new
    @nav = "artists"
  end

  def picture_create
    @artist = Artist.find(params[:picture][:artist_id])
    @picture = Picture.new(params[:picture])
    if @picture.save
      flash[:notice] = "Added image"
    else
      flash[:notice] = "There was a problemo. The image wasn't saved. You probably forgot to add an image."
    end
    redirect_to :action => "picture_new", :id => @artist
  end

  def picture_destroy
    Picture.find(params[:id]).destroy
    flash[:notice] = "Image #{params[:id]} deleted."
    redirect_to :action => 'picture_list'
  end

  def artist_picture_sort
    @artist = Artist.find(params[:id])
    @nav = "artists"
  end                                            

  def picture_sort
    @artist = Artist.find(params[:id])
    @artist.pictures.each do |picture|
      picture.position = params['picture-list'].index(picture.id.to_s) + 1
      picture.save
    end
    render :nothing => true
  end
  def picture_edit
   @picture = Picture.find(params[:id])
   @pageTitle = "Editing: #{@picture.name}"
   @nav = "artists"
   end

   def picture_update
   @picture = Picture.find(params[:id])
   @nav = "artists"
     if @picture.update_attributes(params[:picture])
       flash[:notice] = 'picture was successfully updated.'
       redirect_to :action => 'picture_edit', :id => @picture
     else
       render :action => 'picture_edit'
     end
   end
   
  # Static Icons
  def icon_list
    @statics = Static.find(:all, :order => 'id desc')
    @nav = "information"
  end

  def icon_new
    begin
      @static = Static.find(params[:id])
    rescue
      flash[:notice] = "You must first choose an static before adding images"
      redirect_to :action => 'icon_list'
    end
    @icon = Icon.new
    @nav = "information"
  end

  def icon_create
    @static = Static.find(params[:icon][:static_id])
    @icon = Icon.new(params[:icon])
    if @icon.save
      flash[:notice] = "Added image"
    else
      flash[:notice] = "There was a problemo. The image wasn't saved. You probably forgot to add an image."
    end
    redirect_to :action => "icon_new", :id => @static
  end

  def icon_destroy
    Icon.find(params[:id]).destroy
    flash[:notice] = "Image #{params[:id]} deleted."
    redirect_to :action => 'icon_list'
  end

  def static_icon_sort
    @static = Static.find(params[:id])
    @nav = "information"
  end                                            

  def icon_sort
    @static = Static.find(params[:id])
    @static.icons.each do |icon|
      icon.position = params['icon-list'].index(icon.id.to_s) + 1
      icon.save
    end
    render :nothing => true
  end
   
  def icon_edit
    @icon = Icon.find(params[:id])
    @pageTitle = "Editing: #{@icon.name}"
    @nav = "information"
  end

  def icon_update
    @icon = Icon.find(params[:id])
    @nav = "statics"
    if @icon.update_attributes(params[:icon])
      flash[:notice] = 'icon was successfully updated.'
      redirect_to :action => 'icon_edit', :id => @icon
    else
      render :action => 'icon_edit'
    end
  end
  
  # Product Planes
  def plane_list
    @products = Product.find(:all, :order => 'id desc')
    @nav = "products"
  end

  def plane_new
    begin
      @product = Product.find(params[:id])
    rescue
      flash[:notice] = "You must first choose an product before adding images"
      redirect_to :action => 'plane_list'
    end
    @plane = Plane.new
    @nav = "products"
  end

  def plane_create
    @product = Product.find(params[:plane][:product_id])
    @plane = Plane.new(params[:plane])
    if @plane.save
      flash[:notice] = "Added image"
    else
      flash[:notice] = "There was a problemo. The image wasn't saved. You probably forgot to add an image."
    end
    redirect_to :action => "plane_new", :id => @product
  end

  def plane_destroy
    Plane.find(params[:id]).destroy
    flash[:notice] = "Image #{params[:id]} deleted."
    redirect_to :action => 'plane_list'
  end

  def product_plane_sort
    @product = Product.find(params[:id])
    @nav = "products"
  end                                            

  def plane_sort
    @product = Product.find(params[:id])
    @product.planes.each do |plane|
      plane.position = params['plane-list'].index(plane.id.to_s) + 1
      plane.save
    end
    render :nothing => true
  end

  def plane_edit
    @plane = Plane.find(params[:id])
    @pageTitle = "Editing: #{@plane.name}"
    @nav = "products"
  end

  def plane_update
    @plane = Plane.find(params[:id])
    @nav = "products"
    if @plane.update_attributes(params[:plane])
      flash[:notice] = 'plane was successfully updated.'
      redirect_to :action => 'plane_edit', :id => @plane
    else
      render :action => 'plane_edit'
    end
  end
  
  # deletes
  def picture_deletes
    @artists = Artist.find(:all, :order => 'id desc')
    @nav = "artists"
  end
  def photo_deletes
    @exhibitions = Exhibition.find(:all, :order => 'event_start_at desc')
    @nav = "exhibitions"
  end
  def icon_deletes
    @statics = Static.find(:all, :order => 'name desc')
    @nav = "information"
  end
  def plane_deletes
    @products = Product.find(:all, :order => 'id desc')
    @nav = "products"
  end
end