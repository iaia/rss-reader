# encoding: utf-8
require "feed_reader/feed_xml"

module FeedReader
    class RDF1 < FeedXml
        def self.read(rss, feed_url)
            channel = rss.channel
            articles = get_articles(rss.items)
            get_site(rss, channel, articles, feed_url)
        end

        def self.get_site(rss, channel, articles, feed_url)
            super(type: RSS::RDF, version: rss.rss_version,
                  feed_url: feed_url, url: channel.link.to_s,
                  title: channel.title.to_s, articles: articles)
        end

        def self.get_articles(items)
            items.map do |item|
                super(title: item.title.to_s, 
                      url: item.link.to_s, 
                      published_time: item.dc_dates[-1].content.to_s,
                      description: item.content_encoded.to_s,
                      content: item.description.to_s
                     )
            end
        end
    end
end
