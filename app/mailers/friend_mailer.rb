class FriendMailer < ActionMailer::Base
  default :from => "yeeah88@gmail.com"
  
  def invited_msg(invitation)
	@invitation = invitation
	mail(:to => invitation.guest.email, :subject => "Join the Party!")
  end
  
  def uninvited_msg(invitation)
	@invitation = invitation
	mail(:to => invitation.guest.email, :subject => "You are Uninvited")	
  end
end
