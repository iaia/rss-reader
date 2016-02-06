class Site < ActiveRecord::Base
    has_many :articles
    belongs_to :user

    def self.add(user, url)
        rss = Feed.get(url)
        site_info, entries = Feed.read(rss)

        site = user.sites.create(name: site_info["title"], url: site_info["url"], feed_url: url)
    end

    def self.preview(url)
        rss = Feed.get(url)
        site_info, entries = Feed.read(rss)

        site = Site.new(name: site_info["title"], url: site_info["url"], feed_url: url)
        return site
    end

    def update_site_articles
        rss = Feed.get(self.feed_url)
        site_info, entries = Feed.read(rss)
        entries.each do |entry|
            article = Article.find_or_create_by(
                url: entry["url"],
                site_id: self.id
            ) do |_article|
                _article.title = entry["title"]
                _article.published = entry["published_time"]
                _article.description = entry["description"]
                _article.content = entry["content"]
                _article.save
            end
        end
    end
end
