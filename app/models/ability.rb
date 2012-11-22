class Ability
  include CanCan::Ability

  def initialize(host)
  
    host ||= Host.new 
	
	if host.role? :admin
		can :manage, :all
	elsif host.role? :host
		can :read, Party do |party|
			host.party.map{|p| p.id}.include? party.id
		end
		can :update, Party do |party|
			host.party.map{|p| p.id if p.host_id == host.id}.include? party.id
		end
		can :create, Party
		
		can :read, Location do |location|
			host.location.map{|l| l.id}.include? location.id
		end
		can :update, Location do |location|
			host.location.map{|l| l.id if l.host_id == host.id}.include? location.id
		end
		can :create, Location 
		
		can :read, Guest do |guest|
			host.guest.map{|g| g.id}.include? guest.id
		end
		can :update, Guest do |guest|
			host.guest.map{|g| g.id if g.host_id == host.id}.include? guest.id
		end
		can :create, Guest

		can :read, Invitation do |invitation|
			host.invitation.map{|i| i.id}.include? invitation.id
		end
		can :update, Invitation do |invitation|
			host.invitations.map{|p| p.invitations.map{|i| i.id}}.first.include? invitation.id
		end
		can :create, Invitation		
		
    else
		can :read, :all
    end
	
  end
end
