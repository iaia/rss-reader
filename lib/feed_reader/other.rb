# encoding: utf-8

module FeedReader
    class Other
        def self.read(rss)
            begin
                site = get_site(rss)
                articles = get_articles(rss)
            rescue
            end
            return site, articles
        end
        def self.get_site(rss)
            site = Hash.new()
            site["type"] = rss.class
            site["version"] = ""
            site["title"] = rss.title.content
            site["site_url"] = rss.links[2].href
            site
        end
        def self.get_articles(entries)
            Array.new
        end
    end
end
