class SettingsController < ApplicationController
    before_action :auth, :update_articles

    def setting
    end

    def import_opml
    end


    def upload_opml
    end
end
