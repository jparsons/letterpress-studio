class ReservationsController < ApplicationController
  # GET /reservations
  # GET /reservations.xml
  def index
    
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @holiday = Holiday.find_by_date(@date)
    day_of_the_week = @date.wday + 1 
    @studio_hours = WorkDay.find_by_day_number(day_of_the_week)
    @presses = Press.find :all, :include => [:reservations]
    @pageTitle = "Reserve Press Time"
    @section = "Reservations"
    @links = "yes"  
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reservations }
      format.js { render :layout => false }
    end
  end

  # GET /reservations/1
  # GET /reservations/1.xml
  def show
    @reservation = Reservation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @reservation }
    end
  end

  # GET /reservations/new
  # GET /reservations/new.xml
  def new
    @reservation = Reservation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @reservation }
    end
  end

  # GET /reservations/1/edit
  def edit
    @reservation = Reservation.find(params[:id])
  end

  # POST /reservations
  # POST /reservations.xml
  def create
  
    params[:reservation].each do |reservation|
      Reservation.create(reservation)
    end
    respond_to do |format|
      format.html { redirect_to(reservations_path(:date=>params[:reservation][0][:date])) }
      format.js {
        @date = Date.parse(params[:reservation][0][:date])
        @holiday = Holiday.find_by_date(@date)
        day_of_the_week = @date.wday + 1 
        @studio_hours = WorkDay.find_by_day_number(day_of_the_week)
        @presses = Press.find :all, :include => [:reservations]
        render :action=> :index, :format=>"js"
      }
    end
    
    
    # TODO: add error handling
  end
  
  def bulk_create
  
  for reservation in params[:reservations]
  
  end
  end

  # PUT /reservations/1
  # PUT /reservations/1.xml
  def update
    @reservation = Reservation.find(params[:id])

    respond_to do |format|
      if @reservation.update_attributes(params[:reservation])
        flash[:notice] = 'Reservation was successfully updated.'
        format.html { redirect_to(@reservation) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @reservation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.xml
  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to(reservations_url) }
      format.xml  { head :ok }
    end
  end
end
