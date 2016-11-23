# encoding: utf-8

module FeedReader
    class RSS2
        def self.read(rss)
            channel = rss.channel
            site = get_site(rss, channel)
            articles = get_articles(channel.items)
            return site, articles
        end
        def self.get_site(rss, channel)
            site = Hash.new
            site["type"] = RSS::Rss
            site["version"] = rss.rss_version
            site["title"] = channel.title.to_s
            site["site_url"] = channel.link.to_s
            site
        end
        def self.get_articles(items)
            items.map do |item|
                hentry = Hash.new
                hentry["title"] = item.title.to_s
                hentry["url"] = item.link.to_s
                hentry["published_time"] = item.pubDate.to_s
                hentry["description"] = item.content_encoded.to_s
                hentry["content"] = item.content_encoded.to_s
                hentry
            end
        end
    end
end
