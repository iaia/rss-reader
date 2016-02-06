class FeedController < ApplicationController
    include Feed
    before_action :auth, :update

    def index
    end

    def new
    end

    def preview
        @url = params[:add_feed][:url]
        @site = Feed.get_feed(@url)
        @articles = Article.preview(@url)
    end

    def add
        Site.add(user, params[:url])
        redirect_to action: "index"
    end

    def site
        @site = @sites.find(params[:id])
        render action: "index"
    end

    def auth
        @user = User.find(1)
    end

    def update
        @sites = @user.sites
        @sites.each do |site|
            #Article.update_site_articles(site)
        end
        @articles = Article.where(read: false)
    end
 
end
