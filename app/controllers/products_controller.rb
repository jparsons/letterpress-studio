class ProductsController < ApplicationController
  
  
  # GET /products
  # GET /products.xml
  def index
    @products = Product.active(:order => "name ASC")
    @pageTitle = "Products"
    @section = "Product"
  end
  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.find_by_urlname(params[:id])

    respond_to do |format|
      format.html # product.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/new
  # GET /products/new.xml
  def new
    @product = Product.new
    @nav = "products" 
    respond_to do |format|
      format.html { render :layout => 'admin' }
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find_by_urlname(params[:id])
    @nav = "products" 
    respond_to do |format|
      format.html { render :layout => 'admin' }
      format.xml  { render :xml => @product }
    end    
  end

  # POST /products
  # POST /products.xml
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        flash[:notice] = 'Product was successfully created.'
        format.html { redirect_to(:controller => :admin, :action => :product_list) }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.xml
  def update
    @product = Product.find_by_urlname(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        flash[:notice] = 'Product was successfully updated.'
        format.html { redirect_to(:controller => :admin, :action => :product_list) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
    @product = Product.find_by_urlname(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to(:controller => :admin, :action => :product_list) }
      format.xml  { head :ok }
    end
  end


end