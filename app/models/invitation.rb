class Invitation < ActiveRecord::Base
    attr_accessible :party_id, :guest_id, :invite_code, :expected_attendees, :actual_attendees
	
	belongs_to :guest
	belongs_to :party
	
	before_create :add_invite_code
	
	scope :all, order('party_id')
	scope :for_host, lambda {|host_id| joins(:party).where("host_id = ?", host_id) }

	validates_presence_of :party_id
	validates_presence_of :guest_id, :message => "is not a number"
	validates_numericality_of :expected_attendees, :message => "is not a number"
	validates_numericality_of :expected_attendees, :only_integer => true, :message => "must be an integer"
	validates_numericality_of :expected_attendees, :greater_than => 0, :message => "must be greater than 0"

	def self.authenticate(code)
		invitation = find_by_invite_code(code)
		return invitation unless invitation.nil?
	end	
	
	def self.duplicate?(party,guest)
		invitation = find_by_party_id(party) && find_by_guest_id(guest)
		return true unless invitation.nil?
		return false
	end
	
	
	private
		def add_invite_code
			self.invite_code  = rand(36**16).to_s(36)
		end
		
end
