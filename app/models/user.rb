class User < ActiveRecord::Base
    has_many :sites
    has_many :collections
end
