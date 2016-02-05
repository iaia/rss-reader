class Article < ActiveRecord::Base
    belongs_to :site

    def self.preview(feed_url)
        if feed_url.blank?
            return 
        end
        rss = Feed.get(feed_url)
        site_info, entries = Feed.read(rss)
        p entries
        entries.each do |entry|
            article = Article.create(
                title: entry["title"],
                url: entry["url"],
                published: entry["published_time"],
                description: entry["description"],
                content: entry["content"]
            )
            articles << article
        end
        return articles
    end
    def self.update_site_articles(site)
        rss = Feed.get(feed_url)
        site_info, entries = Feed.read(rss)
        entries.each do |entry|
            article = Article.create(
                title: entry["title"],
                url: entry["url"],
                published: entry["published_time"],
                description: entry["description"],
                content: entry["content"]
            )
            article.save
        end
    end
end
