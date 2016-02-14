class SettingsController < ApplicationController
    before_action :auth, :update_articles

    def setting
    end

    def import_opml
    end

    def preview_opml
        # file_nameチェック .opml
        if File.extname(params[:opml][:file_name].original_filename) != ".opml"
            redirect_to :import_opml #, text: "opmlをuploadしてください"
        end
        file_path = params[:opml][:file_name].tempfile
        xml = File.open(file_path, &:read)
        @reader = ReadOpml::Reader.new(xml)
        @reader.read()
    end

    def regist_opml
        collections = params[:collection]
        sites = params[:site]

        collections.each_pair do |collection_id, value|
            collection = Collection.create(name: value, user_id: @user.id)
            sites.each_value do |site|
                if site["collection_id"] == collection_id
                    p "********************* koko"
                    p site["xml_url"]
                    begin
                        rss = Feed.get(site["xml_url"])
                    rescue
                        next
                    end
                    site_info, entries = Feed.read(rss)
                    Site.create(name: site["title"], url: site_info["url"], feed_url: site["xml_url"], collection_id: collection.id, user_id: @user.id)
                end
            end
        end
        redirect_to :setting
    end

end
