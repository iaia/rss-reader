# encoding: utf-8

require 'rss'

module Feed
    class << self
        def get_feed(url)
            return RSS::Parser.parse(url, false)
        end

        def show_feed(rss)
            if rss.class.to_s == "RSS::Rss" and rss.rss_version == "2.0"
                channel = rss.channel
                p channel.title.to_s
                # feed_url
                p channel.link.to_s
                channel.items.each do |item|
                    p item.title.to_s
                    # feed_id
                    # feed_url
                    p item.link.to_s
                    p item.pubDate.to_s
                    p item.content_encoded.to_s
                end
            elsif rss.class.to_s == "RSS::RDF" and rss.rss_version == "1.0"
                channel = rss.channel
                p channel.title.to_s
                p channel.about.to_s # feed_url
                p channel.link.to_s
                rss.items.each do |item|
                    p item.title.to_s
                    # feed_id
                    # feed_url
                    p item.link.to_s
                    p item.dc_dates[0].content.to_s
                    p item.description.to_s
                end
            elsif rss.class.to_s == "RSS::Atom::Feed"
                p rss.title.content
                p rss.links[0].href #feed_url
                p rss.links[2].href
                rss.entries.each do |entry|
                    p entry.title.content
                    p entry.id.content
                    p entry.links[4].href
                    p entry.links[2].href
                    p entry.published.content
                    p entry.content.content
                end
            end
        end
    end
end

#url = "http://iaiaie.blogspot.com/feeds/posts/default" # atom
#url = "http://blog.livedoor.jp/nicovip2ch/atom.xml" # 壊れたatom
#url = "http://ie.u-ryukyu.ac.jp/news-ie/feed/" # rss2.0
#url = "http://feeds.feedburner.com/mactegaki?format=xml" # RDF1.0
#rss = Feed.get_feed(url)
#feed.show_feed(rss)
