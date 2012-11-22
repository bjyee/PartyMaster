class RsvpsController < ApplicationController
  
  def new
  end

  def create
    invitation = Invitation.authenticate(params[:invite_code])
    if invitation
      redirect_to edit_rsvp_path
    else
      flash.now[:error] = "Invalid invitation code."
      render :action => 'new'
    end
  end
  
  def show
  end
  
  def edit
    invitation = Invitation.authenticate(params[:invite_code])
	if invitation
		@rsvp = invitation
	else
		flash.now[:error] = "Cannot find invitation code"
		render :action => 'new'
	end
  end

  def update
    @rsvp = Invitations.find(params[:invite_code])
	
    respond_to do |format|
      if @rsvp.update_attributes(params[:rsvp])
		flash[:notice] = "Your RSVP is complete. Thank You."
		redirect_to 'show'
      else
        render :action => "edit"
      end
	  
    end
  end
end

