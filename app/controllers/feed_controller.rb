class FeedController < ApplicationController
    include Feed
    before_action :auth, :update

    def index
    end

    def new
    end

    def preview
        @url = params[:add_feed][:url]
        @site = Site.preview(@url)
        @articles = Article.preview(@url)
    end

    def add
        Site.add(@user, params[:url])
        redirect_to action: "index"
    end

    def site
        @site = @sites.find(params[:id])
        @articles = @site.articles.where(read: false)
        render action: "index"
    end

    def auth
        @user = User.find(1)
        @sites = @user.sites
    end

    def update
        @sites.each do |site|
            #site.update_site_articles()
        end
        @articles = Article.where(read: false).order(published: :desc)
        @all_articles_count = @articles.count.to_s
    end
end
