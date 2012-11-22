class AddDefaultUser < ActiveRecord::Migration
  def self.up
	h = Host.new
	h.first_name = "Mrs"
	h.last_name = "Heimann"
	h.username = "MrsH"
	h.email = "Heimann@lolzilla.com"
	h.password = "alex&mark"
	h.password_confirmation = "alex&mark"
	h.role = "admin"
	h.save!
	
  end

  def self.down
	h = Host.where("username = ?", "MrsH").first
	Host.delete h
  end
end
