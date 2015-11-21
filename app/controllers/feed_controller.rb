class FeedController < ApplicationController
    include Feed

    def index
    end

    def add
        @url = params[:add_feed][:url]
        feed = Feed::GetFeed.new()
        @rss = feed.get_feed(@url)
    end
end
