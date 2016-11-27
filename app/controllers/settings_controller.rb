class SettingsController < ApplicationController
    before_action :auth, :update_articles

    def setting
    end

    def import_opml
    end

    def preview_opml
        # file_nameチェック .opml
        if File.extname(params[:opml][:file_name].original_filename) != ".opml"
            redirect_to action: "import_opml" #, text: "opmlをuploadしてください"
        end
        file_path = params[:opml][:file_name].tempfile
        @reader = ReadOpml::Reader.new(file_path)
        @reader.read()
    end

    def regist_opml
        collections = params[:collection]
        sites = params[:site]

        collections.each_pair do |collection_id, value|
            collection = @user.collections.find_or_create_by(name: value)
            sites.each_value do |site|
                if site["collection_id"] == collection_id
                    begin
                        reader = Feed::Feed.read(site["xml_url"])
                    rescue
                        next
                    end
                    site = reader.site_feed
                    collection.sites.find_or_create_by(name: site.title, url: site.url, feed_url: site.feed_url)
                end
            end
        end
        redirect_to action: "setting"
    end

end
