class FeedController < ApplicationController
    include Feed

    def index
        user = User.find(1)
        @rss = []
        user.sites.each do |site|
            feed = Feed::GetFeed.new()
            @rss << feed.get_feed(site.feed_url)
        end
    end

    def preview
        @url = params[:add_feed][:url]
        feed = Feed::GetFeed.new()
        @rss = feed.get_feed(@url)
    end

    def add
        @url = params[:url]
        feed = Feed::GetFeed.new()
        @rss = feed.get_feed(@url)

        user = User.find(1)
        site = user.sites.build(name: @rss.title.content, url: @rss.links[2].href, feed_url: @rss.links[0].href)
        site.save
        redirect_to action: "index"
    end
end
