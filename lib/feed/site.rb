# encoding: utf-8

module Feed
    class Site
        attr_accessor :rss_type, :version, :url, :title, :articles, :feed_url

        def initialize(type:, version:,
                       url:, feed_url:,
                       title:, articles:)
            @rss_type = type
            @version = version
            @url = url
            @title = title
            @articles = articles
            @feed_url = feed_url
        end
    end
end
