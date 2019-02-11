require 'rss'

require 'feed_reader/rss2'
require 'feed_reader/rdf1'
require 'feed_reader/atom'

module FeedReader
  class Reader
    def initialize(url)
      @rss = RSS::Parser.parse(url, false)
    end

    def self.read(url)
      reader = new(url)
      return if reader.nil?
      return unless reader.could_read?

      reader.read(url)
    end

    def could_read?
      return false if @rss.nil?

      true
    end

    def read(url)
      if (@rss.class == RSS::Rss) && (@rss.rss_version == '2.0')
        RSS2.read(@rss, url)
      elsif (@rss.class == RSS::RDF) && (@rss.rss_version == '1.0')
        RDF1.read(@rss, url)
      elsif @rss.class == RSS::Atom::Feed
        Atom.read(@rss, url)
      end
    end
  end
end
