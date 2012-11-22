class Host < ActiveRecord::Base
    attr_accessible :first_name, :last_name, :email, :username, :password, :password_confirmation, :role
	
	has_many :party, :dependent => :destroy
	has_many :guest, :dependent => :destroy
	has_many :location, :dependent => :destroy
	belongs_to :user
	
	attr_accessor :password
	before_save :prepare_password
	
	scope :all, :order => "last_name, first_name"
	
	validates_presence_of :first_name, :last_name, :email, :username
	validates_uniqueness_of :username, :email, :allow_blank => true
	validates_format_of :first_name, :with => /^[A-Z][a-zA-Z ]+$/
	validates_format_of :last_name, :with => /^[A-Z][a-zA-Z .-]+$/
	validates_format_of :email, :with => /^[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))$/i, :message => "is invalid"
	validates_presence_of :password, :on => :create
	validates_confirmation_of :password
	validates_length_of :password, :minimum => 4, :allow_blank => true

	ROLES = [['Administrator', :admin],['Host', :host],['Guest', :guest]]

	def role?(authorized_role)
		return false if role.nil?
		role.to_sym == authorized_role
	end
	
  def self.authenticate(login, pass)
    user = find_by_username(login) || find_by_email(login)
    return user if user && user.matching_password?(pass)
  end

  def matching_password?(pass)
    self.password_hash == encrypt_password(pass)
  end
  
  def check
	errors.add(:password_confirmation, "Password doesn't match confirmation") if (:password == :password_confirmation)
  end


  private

  def prepare_password
    unless password.blank?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = encrypt_password(password)
    end
  end

  def encrypt_password(pass)
    BCrypt::Engine.hash_secret(pass, password_salt)
  end	
end
