class PartyType < ActiveRecord::Base
    attr_accessible :name, :active
	
	has_many :parties
	
	scope :active, where('active = ?', true)
	scope :all, order('name')
	
	validates_presence_of :name
end
