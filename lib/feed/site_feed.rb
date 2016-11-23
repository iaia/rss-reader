# encoding: utf-8

module Feed
    class SiteFeed
        attr_accessor :rss_type, :version, :url, :title, :articles
        def set_articles(articles)
            @articles = ArticleFeed.create_from_hash(articles)
        end

        def set_site(site)
            @rss_type = site["type"]
            @version = site["version"]
            @title = site["title"]
            @url = site["site_url"]
        end
    end
end
