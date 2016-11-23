class Article < ActiveRecord::Base
    belongs_to :site

    def self.preview(feed_url)
        return if feed_url.blank?
        reader = Feed::Feed.read(feed_url)
        return if reader.nil?

        reader.site_feed.articles.map do |article|
            Article.new(
                title: article.title,
                url: article.url,
                published: article.published_time,
                description: article.description,
                content: article.content
            )
        end
    end
end
