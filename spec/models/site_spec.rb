require 'rails_helper'

RSpec.describe Site, type: :model do
    #pending "add some examples to (or delete) #{__FILE__}"
    describe "add method" do
        before(:each) do 
            @user = User.new
            @user.name = "iaia"
            @user.password = "iaia"
            @user.save
            @url = "http://iaiaie.blogspot.com/feeds/posts/default" # atom
            p @user
            p @url
        end
        context "normal case." do
            it "add test " do 
                result = Site.add(@user, @url)
                p result 
            end
        end
    end
end
