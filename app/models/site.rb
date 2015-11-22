class Site < ActiveRecord::Base
    has_many :articles
    belongs_to :user
end
