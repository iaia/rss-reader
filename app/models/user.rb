class User < ActiveRecord::Base
    has_many :collections
    has_many :site_users
    has_many :sites, :through => :site_users
    has_many :articles, :through => :article_users
end
