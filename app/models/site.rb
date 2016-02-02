class Site < ActiveRecord::Base
    has_many :articles
    belongs_to :user

    def self.add(user, url)
        rss = Feed.get_feed(url)

        if rss.class.to_s == "RSS::Rss" and rss.rss_version == "2.0"
            channel = rss.channel
            #p channel.title.to_s
            # feed_url
            #p channel.link.to_s
            site = user.sites.build(name: channel.title.to_s, url: channel.link.to_s, feed_url: rss.links[0].href)
        elsif rss.class.to_s == "RSS::RDF" and rss.rss_version == "1.0"
            channel = rss.channel
            #p channel.title.to_s
            #p channel.about.to_s # feed_url
            #p channel.link.to_s
            site = user.sites.build(name: rss.title.content, url: rss.links[2].href, feed_url: rss.links[0].href)
        elsif rss.class.to_s == "RSS::Atom::Feed"
            #p rss.title.content
            #p rss.links[0].href #feed_url
            #p rss.links[2].href
            site = user.sites.build(name: rss.title.content, url: rss.links[2].href, feed_url: rss.links[0].href)
        end
        site.tap(&:save)
    end
end
