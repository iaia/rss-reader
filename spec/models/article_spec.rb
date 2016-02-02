require 'rails_helper'

RSpec.describe Article, type: :model do
    #pending "add some examples to (or delete) #{__FILE__}"
    describe "preview method" do
        before(:each) do 
            @url = ""
            @url = "http://blog.livedoor.jp/nicovip2ch/atom.xml" # 壊れたatom
        end
        context "壊れたatom case." do
            it "not nil" do 
                Article.preview(@url).should_not be_nil
            end
        end
    end
end
