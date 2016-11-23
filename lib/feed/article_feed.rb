# encoding: utf-8

module Feed
    class ArticleFeed
        attr_accessor :title, :url, :published_time, :description, :content
        def initialize(title, url, published_time, description, content)
            @title = title
            @url = url
            @published_time = published_time
            @description = description
            @content = content
        end
        def self.create_from_hash(h_articles)
            h_articles.map do |h_article|
                self.new(
                    h_article["title"],
                    h_article["url"],
                    h_article["published_time"],
                    h_article["description"],
                    h_article["content"]
                )
            end
        end
    end
end
