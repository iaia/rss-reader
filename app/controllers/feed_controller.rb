class FeedController < ApplicationController
    include Feed

    def index
        user = User.find(1)
        article_ids = []
        user.sites.each do |site|
            feed = Feed::GetFeed.new()
            rss = feed.get_feed(site.feed_url)
            rss.entries.each do |entry|
                if user.sites.articles.exists?(entry_id: entry.id.content)
                    next
                end
                user.sites.articles.build(
                    title: entry.title.content,
                    entry_id: entry.id.content,
                    url: entry.links[4].href,
                    feed_url: entry.links[2].href,
                    published: entry.published.content,
                    content: entry.content.content
                )
                user.sites.articles.save
                article_ids << user.sites.articles.id
            end
        end
        p user.sites.articles

        if user.sites.articles.count() != 0
            @articles = user.sites.articles.where(id: article_ids)
        else
            @articles = []
        end
    end

    def preview
        @url = params[:add_feed][:url]
        feed = Feed::GetFeed.new()
        @rss = feed.get_feed(@url)
    end

    def add
        url = params[:url]
        feed = Feed::GetFeed.new()
        rss = feed.get_feed(url)

        user = User.find(1)
        site = user.sites.build(name: rss.title.content, url: rss.links[2].href, feed_url: rss.links[0].href)
        site.save
        redirect_to action: "index"
    end
end
