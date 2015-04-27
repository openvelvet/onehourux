class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:linkedin]

  has_one :profile, dependent: :destroy

  

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
        user.summary = auth.info.summary
        user.connections = auth.info.num_connections
      end
  end
end