# encoding: utf-8
require "rss"
require "feed/feed"
require "feed/site_feed"

require "feed_reader/rss2"
require "feed_reader/rdf1"
require "feed_reader/atom"

module FeedReader
    class Reader
        attr_accessor :site_feed
        def initialize(url)
            begin
                @rss = RSS::Parser.parse(url, false)
            rescue
                return
            end
        end

        def could_read?
            return false if @rss.nil?
            true
        end

        def self.read(url)
            reader = self.new(url)
            return if reader.nil?
            return if not reader.could_read?
            site, articles = reader.read
            reader.site_feed = Feed::SiteFeed.new(site, articles)
            reader
        end

        def read
            if @rss.class == RSS::Rss and @rss.rss_version == "2.0"
                RSS2.read(@rss)
            elsif @rss.class == RSS::RDF and @rss.rss_version == "1.0"
                RDF1.read(@rss)
            elsif @rss.class == RSS::Atom::Feed
                Atom.read(@rss)
            else
                p "*********** other rss"
                Other.read(@rss)
            end
        end
    end
end
