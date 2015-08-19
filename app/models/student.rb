require_relative '../../db/config'
require 'date'
class Student < ActiveRecord::Base
	validates_format_of :email, :with =>  /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :on => :create
  	validates :email, uniqueness: true
  	validate :not_toddler?
  	validates_length_of :phone, :minimum => 10

  	def not_toddler?
	    age = (Date.today.year - birthday.year)
	    errors.add(:birthday,"Come back in a few years") unless age > 5
  	end
  	def name
    	"#{first_name} #{last_name}"
  	end

  	def age
    	now = Time.now.utc.to_date
    	@age = now.year - birthday.year - (birthday.to_date.change(:year => now.year) > now ? 1 : 0)
  	end
  	def strip_phone
	    phone_number = :phone
	    @phone = phone_number.map {|x| x[/\d+/]}
  	end
end