class SettingsController < ApplicationController
    before_action :auth, :update
    def setting
    end
    def import_opml
    end

    def auth
        @user = User.find(1)
        @sites = @user.sites
    end

    def update
        @articles = Article.where(read: false).order(published: :desc)
        @all_articles_count = @articles.count.to_s
    end
end
