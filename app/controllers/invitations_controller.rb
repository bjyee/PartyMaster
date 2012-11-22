class InvitationsController < ApplicationController

  def index
    @invitations = Invitation.all.for_host(current_host).paginate :page => params[:page]
  end

  def show
    @invitation = Invitation.find(params[:id])
  end

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(params[:invitation])
	unless Invitation.duplicate?(@invitation.party_id, @invitation.guest_id)
		if @invitation.save
		  FriendMailer.invited_msg(@invitation).deliver
		  flash[:notice] = "Invitation was successfully created"
		  redirect_to @invitation
		else
		  render :action => 'new'
		end
	else
	  if @invitation.update_attributes(params[:invitation])
		FriendMailer.invited_msg(@invitation).deliver
		flash[:notice] = "The invitation for this guest has been updated."
		redirect_to @invitation
	  else
		render :action => 'new'
      end
	end
  end

  def edit
    @invitation = Invitation.find(params[:id])
  end

  def update
    @invitation = Invitation.find(params[:id])
    if @invitation.update_attributes(params[:invitation])
      flash[:notice] = "The invitation for this guest has been updated."
      redirect_to invitation_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @invitation = Invitation.find(params[:id])
    @invitation.destroy
	
    FriendMailer.uninvited_msg(@invitation).deliver
	flash[:notice] = "Invitation was successfully destroyed"
    redirect_to invitations_url
  end
end
