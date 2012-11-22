class ApplicationController < ActionController::Base
  include ControllerAuthentication
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
	flash[:error] = "You are unauthorized to access this page."
	redirect_to root_url
  end
  
  def current_user
	current_host
  end

end
