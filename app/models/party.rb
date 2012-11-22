class Party < ActiveRecord::Base
    attr_accessible :host_id, :name, :party_date, :party_type_id, :location_id, :start_time, :end_time, :description, :rsvp_date 
	
	belongs_to :host
	belongs_to :location
	has_many :guests, :dependent => :destroy
	belongs_to :party_type
	has_many :invitations, :dependent => :destroy
	
	scope :all, order('name')
	scope :for_host, lambda {|host_id| where("host_id = ?", host_id) }

	validates_presence_of :host_id, :name, :location_id
	validates_time :end_time, :after => :start_time, :message => "must be after"
	validate :rsvp
	validate :date
	
	def confirmed
		self.invitations.sum('actual_attendees')
	end
		
	def expected
		self.invitations.sum('expected_attendees')
	end

	def rsvp
		return true if self.rsvp_date.nil?
		self.errors.add :rsvp_date, "must be on or before" unless (self.rsvp_date <= self.party_date)
	end	
	
	def date
		return true if self.party_date.nil?
		self.errors.add :party_date, "must be on or after" unless (self.party_date >= Time.now.strftime("%Y-%m-%d").to_date)
	end
	
end
