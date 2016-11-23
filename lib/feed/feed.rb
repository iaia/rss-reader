# encoding: utf-8
require 'rss'
require "feed_reader/feed_reader"
require "feed/site_feed"
require "feed/article_feed"

module Feed
    class Feed
        def self.read(url)
            FeedReader::Reader.read(url)
        end
    end
end
