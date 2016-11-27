class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
        :omniauth_providers => [:google_oauth2]
    has_many :collections
    has_many :site_users
    has_many :sites, :through => :site_users
    has_many :articles, :through => :article_users
    def self.find_for_google_oauth2(auth)
        user = User.where(email: auth.info.email).first

        unless user
            user = User.create(name:     auth.info.name,
                               provider: auth.provider,
                               uid:      auth.uid,
                               email:    auth.info.email,
                               token:    auth.credentials.token,
                               password: Devise.friendly_token[0, 20],
                               meta:     auth.to_yaml)
        end
        user
    end
end
