class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    def auth
        if session[:user_id]
            @user = User.find(session[:user_id])
            @collections = @user.collections
        else
            redirect_to controller: "user", action: "index"
        end
    end

    def update_articles
        read_articles = @user.articles
        @collections.each do |collection|
            unread_num = 0
            collection.sites.each do |site|
                # 記事取得
                site.update_site_articles()
                # 未読計算
                site.unread_num = site.articles.where.not(id: read_articles.id).count.to_i
                unread_num += site.unread_num.to_i
            end
            collection.unread_num = unread_num
        end
        @articles = Article.where.not(id: read_articles.id).order(published: :desc)
        @all_articles_count = @articles.count.to_i
        @articles = @articles.limit(20)
    end
end

