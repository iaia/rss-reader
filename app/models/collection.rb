class Collection < ActiveRecord::Base
  has_many :sites
  belongs_to :user

  attr_accessor :unread_num
end
