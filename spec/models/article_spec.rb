require 'rails_helper'

RSpec.describe Article, type: :model do
    #pending "add some examples to (or delete) #{__FILE__}"
    describe "preview method" do
        before(:each) do 
            @url = "http://blog.livedoor.jp/nicovip2ch/atom.xml" # 壊れたatom
        end
        context "壊れたatom case." do
            it "not nil" do 
                p @url
                articles = Article.preview(@url).should_not be_nil
            end
        end
    end
    describe "update_site_articles method" do
        before(:each) do 
            @user = User.create(name: "iaia", password: "iaia")
            @url = "http://blog.livedoor.jp/nicovip2ch/atom.xml" # 壊れたatom
            Site.add(@user, @url)
            @sites = @user.sites
        end
        context "site update" do
            it "not nil" do 
                @sites.each do |site|
                    site.articles.update_site_articles()
                end
            end
        end
    end
end
