class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    def auth
        debugger
        if session[:user_id].nil?
            redirect_to controller: "users", action: "login"
        else
            @user = User.find(session[:user_id])
            @collections = @user.collections
        end
    end

    def update_articles
        @collections.each do |collection|
            unread_num = 0
            collection.sites.each do |site|
                site.update_site_articles()
                site.unread_num = site.articles.where(read: false).count.to_i
                unread_num += site.unread_num.to_i
            end
            collection.unread_num = unread_num
        end
        @articles = Article.where(read: false).order(published: :desc)
        @all_articles_count = @articles.count.to_s
        @articles = @articles.limit(20)
    end
end

