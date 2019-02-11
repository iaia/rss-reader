require 'rails_helper'

RSpec.describe Site, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'add method' do
    before(:each) do
      @user = User.new
      @user.name = 'iaia'
      @user.password = 'iaia'
      @user.save
      @url = 'http://iaiaie.blogspot.com/feeds/posts/default' # atom
      p @user
      p @url
    end
    context 'normal case.' do
      it 'add test ' do
        result = Site.add(@user, @url)
        p result
      end
    end
  end

  describe 'update_site_articles method' do
    before(:each) do
      @user = User.create(name: 'iaia', password: 'iaia')
      @url = 'http://blog.livedoor.jp/nicovip2ch/atom.xml' # 壊れたatom
      Site.add(@user, @url)
      @sites = @user.sites
    end
    context 'site update' do
      it '1度だけ' do
        @sites.each(&:update_site_articles)
      end
      it '同じものが入るとき' do
        @sites.each(&:update_site_articles)
        @sites.each(&:update_site_articles)
      end
    end
  end
end
