# encoding: utf-8

require 'rss'

module Feed
    class GetFeed
        def initialize
        end
        def get_feed(url)
            return RSS::Parser.parse(url)
        end
        def show_feed(rss)
            rss.title.content
            rss.links[2].href

            rss.entries.each do |entry|
                entry.title.content
                entry.links[4].href
                entry.published.content
                entry.content.content
            end
        end
    end
end

#feed = Feed::Feed.new()
#feed.get_feed("http://iaiaie.blogspot.com/feeds/posts/default")
