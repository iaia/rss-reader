class Article < ActiveRecord::Base
    belongs_to :site

    def self.preview(feed_url)
        if feed_url.blank?
            return 
        end
        rss = Feed.get(feed_url)
        site_info, entries = Feed.read(rss)
        articles = Array.new
        entries.each do |entry|
            article = Article.new(
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
end
