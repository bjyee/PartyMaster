class Guest < ActiveRecord::Base
    attr_accessible :host_id, :name, :email, :notes
	
	belongs_to :host
	has_many :invitation, :dependent => :destroy
	
	scope :all, order('name')	
	scope :for_host, lambda {|host_id| where('host_id = ?', host_id) }
	
	validates_presence_of :name, :email
	validates_format_of :email, :with => /^[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))$/i, :message => "is not a valid format"

end