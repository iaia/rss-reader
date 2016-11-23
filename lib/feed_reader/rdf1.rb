# encoding: utf-8

module FeedReader
    class RDF1
        def self.read(rss)
            channel = rss.channel
            site = get_site(rss, channel)
            articles = get_articles(rss.items)
            return site, articles
        end
        def self.get_site(rss, channel)
            site = Hash.new
            site["type"] = RSS::RDF
            site["version"] = rss.rss_version
            site["title"] = channel.title.to_s
            site["site_url"] = channel.link.to_s
            site
        end
        def self.get_articles(items)
            items.map do |item|
                entry = Hash.new
                entry["title"] = item.title.to_s
                entry["url"] = item.link.to_s
                entry["published_time"] = item.dc_dates[-1].content.to_s
                entry["content"] = item.content_encoded.to_s
                entry["description"] = item.description.to_s
                entry
            end
        end
    end
end
