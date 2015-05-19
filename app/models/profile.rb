class Profile < ActiveRecord::Base

	belongs_to :user
	has_many :orders

	validates :years_of_experience, :experience_level, :price, :portfolio_link, presence: true
end
