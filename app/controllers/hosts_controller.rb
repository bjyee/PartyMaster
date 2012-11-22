class HostsController < ApplicationController
  before_filter :login_required, :except => [:new, :create]

  def index
    @hosts = Host.all.paginate :page => params[:page]
  end
  
  def show
    @host = Host.find(params[:id])
  end
  
  def new
    @host = Host.new
  end

  def create
    @host = Host.new(params[:host])
    if @host.save
      session[:host_id] = @host.id
      flash[:notice] = "Thank you for signing up! You are now logged in."
      redirect_to "/"
    else
      render :action => 'new'
    end
  end

  def edit
    @host = current_host
  end

  def update
    @host = current_host
    if @host.update_attributes(params[:host])
      flash[:notice] = "Welcome, #{current_host.first_name} #{current_host.last_name}"
      redirect_to "/"
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @host = Host.find(params[:id])
    @host.destroy
    flash[:notice] = "Successfully destroyed host."
    redirect_to hosts_url
  end
end
