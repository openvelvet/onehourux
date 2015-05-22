class Profile < ActiveRecord::Base

	belongs_to :user
	has_many :orders
	has_many :reviews, dependent: :destroy

	validates :years_of_experience, :experience_level, :price, :portfolio_link, presence: true
end
