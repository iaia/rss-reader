class SettingsController < ApplicationController
  before_action :auth, :update_articles

  def setting; end

  def import_opml; end

  def preview_opml
    # file_nameチェック .opml
    if File.extname(params[:opml][:file_name].original_filename) != '.opml'
      redirect_to action: 'import_opml' # , text: "opmlをuploadしてください"
    end
    @reader = ReadOpml::Reader.read(params[:opml][:file_name].tempfile)
  end

  def regist_opml
    p 'aaa'
    @collection = params[:collection]
    collections = params[:collection]
    sites = params[:site]

    collections.each_pair do |collection_id, value|
      collection = @user.collections.find_or_create_by(name: value)
      sites.each_value do |site|
        next unless site['collection_id'] == collection_id

        begin
          site_feed = Feed::Feed.read(site['xml_url'])
        rescue StandardError
          next
        end
        collection.sites.find_or_create_by(name: site_feed.title, url: site_feed.url, feed_url: site_feed.feed_url)
      end
    end
    # redirect_to action: "setting"
  end
end
