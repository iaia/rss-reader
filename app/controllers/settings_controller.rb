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
        reader = ReadOpml::Reader.new(xml)
        reader.read()
        @collections = []
        @sites = []
        reader.category.each_pair do |category_name, tmp_sites|
            collection = Collection.new(name: category_name)
            @collections.push(collection)
            tmp_sites.each do |tmp_site|
                site = Site.new(
                    name: tmp_site["title"],
                    url: tmp_site["html_url"],
                    feed_url: tmp_site["xml_url"],
                    collection_id: collection.id
                )
                @sites.push(site)
            end
        end
    end

    def regist_opml
        redirect_to :setting
    end

end
