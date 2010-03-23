class UsersController < ApplicationController

  before_filter :admin_required, :only=>[:index]
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if User.all.blank?
      @user.role = "administrator"
    else
      @user.role = "unconfirmed"
    end
    if @user.save
      # send mail to user
      flash[:notice] = "Thank you for signing up! Your request will be reviewed as soon as possible."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
  def index
    @unconfirmed_users = User.unconfirmed
    @confirmed_users = User.confirmed
    @suspended_users = User.suspended
    @admin_users = User.admin

    render :layout=>"admin"
  end
  
  def edit
    @user = User.find(params[:id])
    render :layout => "admin"
  end
  
  def update
    @user = User.find(params[:id])

    @user.update_attributes(params[:user])
    
    if @user.save
      flash[:notice] = "That user has been updated"
      redirect_to users_path
    else
      render :edit, :layout=>"admin"
    end
   
  end
  
  def confirm
    @user = User.find(params[:id]) 
    @user.update_attribute(:role, "confirmed")
    flash[:notice] = "That user has been confirmed"
    # send mail to user
    redirect_to users_path
  end
  
  def suspend
    @user = User.find(params[:id]) 
    @user.update_attribute(:role, "suspended")
    flash[:notice] = "That user has been suspended"
    # send mail to user? 
    redirect_to users_path
  end
  
  def unsuspend
    @user = User.find(params[:id]) 
    @user.update_attribute(:role, "confirmed")
    flash[:notice] = "That user has been unsuspended"
    # send mail to user 
    redirect_to users_path
  end
  
  def show
    @nav = "users"
    @user = User.find(params[:id]) 
    render :layout=> "admin"
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:notice] = "That user has been destroyed"

    redirect_to users_path
  end
end
