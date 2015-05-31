class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:linkedin]

  has_one :profile, dependent: :destroy
  has_one :recruiter, dependent: :destroy
  has_many :sales, class_name: "Order", foreign_key: "seller_id"
  has_many :purchases, class_name: "Order", foreign_key: "buyer_id"
  has_many :reviews, dependent: :destroy

  after_create :send_notification

  def send_notification
    MyMailer.new_user(self).deliver_now
  end

  validates :email, uniqueness: true

  acts_as_messageable

  def mailboxer_email(object)
    #Check if an email should be sent for that object
      #if true
        return email
      #if false
        #return nil
    end

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
        user.linkedin_position = auth.extra.raw_info.positions.values
      end
  end
end