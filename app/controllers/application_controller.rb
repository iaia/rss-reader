class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    def auth
        @user = User.find(1)
        @sites = @user.sites
    end

    def update_articles
        @sites.each do |site|
            #site.update_site_articles()
        end
        @articles = Article.where(read: false).order(published: :desc)
        @all_articles_count = @articles.count.to_s
    end
end

