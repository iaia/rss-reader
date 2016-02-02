class Article < ActiveRecord::Base
    belongs_to :site

    def self.preview(feed_url)
        if feed_url.blank?
            return 
        end
        rss = Feed.get_feed(feed_url)
        articles = []
        rss_class = rss.class.to_s 
        p rss_class
        if rss_class == "RSS::Atom::Feed"
            rss_version = ""
        else
            rss_version = rss.rss_version
        end
        if rss_class == "RSS::Rss" and rss_version == "2.0"
            rss.items.each do |entry|
                article = Article.create(
                    title: entry.title.to_s,
                    #entry_id: entry.id.content,
                    url: entry.link.to_s,
                    #feed_url: entry.links.to_s,
                    published: entry.pubDate.to_s,
                    content: entry.content_encoded.to_s
                )
                articles << article
            end
        elsif rss_class == "RSS::Atom::Feed"
            rss.entries.each do |entry|
                p entry.title.content
                p entry.id.content
                p entry.links[4].href
                p entry.links[2].href
                p entry.published.content
                p entry.content.content

                article = Article.create(
                    title: entry.title.content,
                    entry_id: entry.id.content,
                    url: entry.links[4].href,
                    feed_url: entry.links[2].href,
                    published: entry.published.content,
                    content: entry.content.content
                )
                articles << article
            end
        elsif rss_class == "RSS::RDF" and rss_version == "1.0"
            rss.channel.each do |entry|
                article = site.articles.build(
                    title: entry.title.to_s,
                    #entry_id: entry.id.content,
                    url: entry.link.to_s,
                    #feed_url: entry.[2].href,
                    published: entry.dc_dates[0].content.to_s,
                    content: entry.description.to_s
                )
                articles << article
            end
        end
        return articles
    end
    def self.update_site_articles(site)
        rss = Feed.get_feed(site.feed_url)
        if rss.class.to_s == "RSS::Rss" and rss.rss_version == "2.0"
            rss.channel.each do |entry|
                if site.articles.exists?(entry_id: entry.id.content)
                    next
                end
                article = site.articles.build(
                    title: entry.title.to_s,
                    #entry_id: entry.id.content,
                    url: entry.links.to_s,
                    #feed_url: entry.links.to_s,
                    published: entry.pubDate.to_s,
                    content: entry.content_encoded.content
                )
                article.save
            end
        elsif rss.class.to_s == "RSS::Atom::Feed"
            rss.entries.each do |entry|
                if site.articles.exists?(entry_id: entry.id.content)
                    next
                end
                article = site.articles.build(
                    title: entry.title.content,
                    entry_id: entry.id.content,
                    url: entry.links[4].href,
                    feed_url: entry.links[2].href,
                    published: entry.published.content,
                    content: entry.content.content
                )
                article.save
            end
        elsif rss.class.to_s == "RSS::RDF" and rss.rss_version == "1.0"
            rss.channel.each do |entry|
                if site.articles.exists?(entry_id: entry.id.content)
                    next
                end
                article = site.articles.build(
                    title: entry.title.to_s,
                    #entry_id: entry.id.content,
                    url: entry.link.to_s,
                    #feed_url: entry.[2].href,
                    published: entry.dc_dates[0].content.to_s,
                    content: entry.description.to_s
                )
                article.save
            end
        end
    end
end
