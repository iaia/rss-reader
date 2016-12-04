# encoding: utf-8
require "feed_reader/feed_xml"

module FeedReader
    class Atom < FeedXml
        def self.read(rss, feed_url)
            articles = get_articles(rss.entries)
            get_site(rss, articles, feed_url)
        end

        def self.get_site(rss, articles, feed_url)
            super(type: RSS::Atom::Feed, version: "",
                  feed_url: feed_url, url: get_site_url(rss.links),
                  title: rss.title.content, articles: articles)
        end

        def self.get_site_url(links)
            if links.length > 2
                links[2].href
            else
                links[0].href
            end
        end

        def self.get_articles(entries)
            entries.map do |entry|
                super(title: entry.title.content, 
                      url: entry.links[-1].href, 
                      published_time: get_published_time(entry.published),
                      description: entry.content.content,
                      content: entry.content.content
                     )
            end
        end

        def self.get_published_time(published)
            if published.nil?
                Time.now
            else
                published.content
            end
        end
    end # class Atom
end # module FeedReader
