class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    def auth
        @user = User.find(1)
        @collections = @user.collections
    end

    def update_articles
        @collections.each do |collection|
            unread_num = 0
            collection.sites.each do |site|
                #site.update_site_articles()
                site.unread_num = site.articles.where(read: false).count.to_i
                unread_num += site.unread_num.to_i
            end
            collection.unread_num = unread_num
        end
        @articles = Article.where(read: false).order(published: :desc)
        @all_articles_count = @articles.count.to_s
    end
end

