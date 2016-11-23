# encoding: utf-8

module FeedReader
    class Atom
        def self.read(rss)
            site = get_site(rss)
            articles = get_articles(rss.entries)
            return site, articles
        end
        def self.get_site(rss)
            site = Hash.new()
            site["type"] = RSS::Atom::Feed
            site["version"] = ""
            site["title"] = rss.title.content
            begin
                site["site_url"] = rss.links[2].href
            rescue
                site["site_url"] = rss.links[0].href
            end
            site
        end
        def self.get_articles(entries)
            entries.map do |entry|
                hentry = Hash.new
                hentry["title"] = entry.title.content
                hentry["url"] = entry.links[-1].href
                if entry.published.nil?
                    hentry["published_time"] = Time.now
                else
                    hentry["published_time"] = entry.published.content
                end
                hentry["content"] = entry.content.content
                hentry["description"] = entry.content.content
                hentry
            end
        end
    end
end
