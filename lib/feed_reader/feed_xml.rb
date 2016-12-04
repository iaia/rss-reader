# encoding: utf-8
require "feed/site"
require "feed/article"

module FeedReader
    class FeedXml
        def self.get_site(type:, version:,
                          url:, feed_url:,
                          title:, articles:)

            Feed::Site.new(type: type, version: version, 
                           url: url, feed_url: feed_url,
                           title: title, articles: articles)
        end

        def self.get_articles(title:, url:,
                              published_time: Time.now,
                              description:, content:)

            Feed::Article.new(title: title, 
                              url: url, 
                              published_time: published_time,
                              description: description,
                              content: content)
        end
    end
end
