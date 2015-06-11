class Order < ActiveRecord::Base

	validates :address, :city, :state, :zip_code, presence: true

	belongs_to :profile
	belongs_to :customer
	belongs_to :seller, class_name: "User"
	
end
