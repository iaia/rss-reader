# encoding: utf-8
require "rss"
require "feed/feed"

require "feed_reader/rss2"
require "feed_reader/rdf1"
require "feed_reader/atom"

module FeedReader
    class Reader
        attr_accessor :site_feed
        def initialize(url)
            @rss = RSS::Parser.parse(url, false)
            @site_feed = Feed::SiteFeed.new
            read
        end

        def self.read(url)
            reader = self.new(url)
            site, articles = reader.read
            reader.site_feed.set_articles(articles)
            reader.site_feed.set_site(site)
            reader
        end

        def read
            if @rss.class == RSS::Rss and @rss.rss_version == "2.0"
                RSS2.read(@rss)
            elsif @rss.class == RSS::RDF and @rss.rss_version == "1.0"
                RDF1.read(@rss)
            elsif @rss.class == RSS::Atom::Feed
                Atom.read(@rss)
            end
        end
    end
end
