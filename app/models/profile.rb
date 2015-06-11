class Profile < ActiveRecord::Base

	searchkick 

	belongs_to :user
	has_many :orders
	has_many :reviews, dependent: :destroy
  
	acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :industries, :companies


	validates :years_of_experience, :experience_level, :portfolio_link, :tag_list, :industry_list, :company_list, presence: true
	validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
	validates :company, :location, :summary, :image, :title, :linked_link, presence: true, unless: :email_signup?


	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "16x16>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def email_signup?
  	self.user.provider == "linkedin"
  end

  def search_data
  	{
  		title: title,
  		company: company,
  		user_title: user.headline,
  		industry: user.industry,
  		tag_name: tags.map(&:name),
  		first_name: user.first_name,
  		last_name: user.last_name,
  		location: user.location,
  		location1: location,
  	}
  end

  def self.facets_search(params)
    query = params[:query].presence || "*"
    conditions = {}
    conditions[:first_name] = params[:first_name] if params[:first_name].present?

    profiles = Profile.search query, where: conditions, 
      facets: [:first_name], 
      smart_facets: true, page: params[:page], suggest: true, highlight: true,
      per_page: 10
    profiles
  end

  

end
