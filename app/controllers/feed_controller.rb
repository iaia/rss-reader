class FeedController < ApplicationController
    include Feed
    before_action :auth

    def index
        @sites = @user.sites
        @sites.each do |site|
            Article.update_site_articles(site)
        end
        @articles = Article.where(read: false)
    end

    def preview
        @url = params[:add_feed][:url]
        feed = Feed::GetFeed.new()
        @site = feed.get_feed(@url)
        @articles = Article.preview(@url)
    end

    def add
        Site.add(user, params[:url])

        redirect_to action: "index"
    end

    def site
        @sites = @user.sites
        @site = @user.sites.find(params[:id])
        @articles = Article.where(read: false)

        render action: "index"
    end

    def auth
        @user = User.find(1)
    end
end
