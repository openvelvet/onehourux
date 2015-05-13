class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:linkedin]

  has_one :profile, dependent: :destroy
  has_one :recruiter, dependent: :destroy
  has_many :sales, class_name: "Order", foreign_key: "seller_id"
  has_many :purchases, class_name: "Order", foreign_key: "buyer_id"

  has_attached_file :image, :styles => { :medium => "300x>", :thumb => "100x100>" }, :default_url => "default.jpg"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  validates :email, uniqueness: true

  

  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.headline = auth.info.headline
        user.first_name = auth.info.first_name
        user.last_name = auth.info.last_name
        user.industry = auth.info.industry
        user.location = auth.info.location
        user.summary = auth.extra.raw_info.summary
        user.connections = auth.extra.raw_info.numConnections
        user.linkedin_photo_url = auth.info.image
        user.linkedin_url = auth.info.urls.public_profile
        user.linkedin_position = auth.extra.raw_info.languages
      end
  end
end