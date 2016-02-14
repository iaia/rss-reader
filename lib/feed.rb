# encoding: utf-8
require 'rss'

module Feed
    class << self
        def get(url)
            return RSS::Parser.parse(url, false)
        end

        def read(rss)
            site = Hash.new
            entries = Array.new
            site["class"] = rss.class.to_s
            if rss.class.to_s == "RSS::Rss" and rss.rss_version == "2.0"
                channel = rss.channel
                site["version"] = rss.rss_version
                site["title"] = channel.title.to_s
                site["site_url"] = channel.link.to_s
                channel.items.each do |item|
                    entry = Hash.new
                    entry["title"] = item.title.to_s
                    entry["url"] = item.link.to_s
                    entry["published_time"] = item.pubDate.to_s
                    entry["description"] = item.content_encoded.to_s
                    entry["content"] = item.content_encoded.to_s
                    entries.push(entry)
                end
            elsif rss.class.to_s == "RSS::RDF" and rss.rss_version == "1.0"
                p rss
                channel = rss.channel
                site["version"] = rss.rss_version
                site["title"] = channel.title.to_s
                site["site_url"] = channel.link.to_s
                rss.items.each do |item|
                    entry = Hash.new
                    entry["title"] = item.title.to_s
                    entry["url"] = item.link.to_s
                    entry["published_time"] = item.dc_dates[-1].content.to_s
                    entry["content"] = item.content_encoded.to_s
                    entry["description"] = item.description.to_s
                    entries.push(entry)
                end
            elsif rss.class.to_s == "RSS::Atom::Feed"
                site["version"] = ""
                site["title"] = rss.title.content
                begin
                    site["site_url"] = rss.links[2].href
                rescue
                    site["site_url"] = rss.links[0].href
                end
                rss.entries.each do |_entry|
                    entry = Hash.new
                    entry["title"] = _entry.title.content
                    entry["url"] = _entry.links[-1].href
                    if _entry.published.nil?
                        entry["published_time"] = Time.now
                    else
                        entry["published_time"] = _entry.published.content
                    end
                    entry["content"] = _entry.content.content
                    entry["description"] = _entry.content.content
                    entries.push(entry)
                end
            else
                site["version"] = ""
                site["title"] = rss.title.content
                site["site_url"] = rss.links[2].href
            end
            return site, entries
        end

        def show(rss)
            if rss.class.to_s == "RSS::Rss" and rss.rss_version == "2.0"
                p "Rss2.0"
                channel = rss.channel
                p rss.rss_version
                p channel.title.to_s
                p channel.link.to_s
                channel.items.each do |item|
                    p item.title.to_s
                    p item.link.to_s
                    p item.pubDate.to_s
                    p item.content_encoded.to_s
                    p item.content_encoded.to_s
                end
            elsif rss.class.to_s == "RSS::RDF" and rss.rss_version == "1.0"
                p "RDF1.0"
                channel = rss.channel
                p rss.rss_version
                p channel.title.to_s
                p channel.link.to_s
                rss.items.each do |item|
                    p item.title.to_s
                    p item.link.to_s
                    p item.dc_dates[-1].content.to_s
                    p item.content_encoded.to_s
                    p item.description.to_s
                end
            elsif rss.class.to_s == "RSS::Atom::Feed"
                p "Atom0"
                p rss.title.content
                begin
                    p rss.links[2].href
                rescue
                    p rss.links[0].href
                end

                rss.entries.each do |_entry|
                    p _entry.title.content
                    p _entry.links[-1].href
                    p _entry.content.content
                    p _entry.content.content
                end
            end
       end
    end
end

#url = "http://iaiaie.blogspot.com/feeds/posts/default" # atom atom11
#url = "http://blog.livedoor.jp/nicovip2ch/atom.xml" # 壊れたatom atom10
#url = "http://ie.u-ryukyu.ac.jp/news-ie/feed/" # rss2.0 rss20
#url = "http://feeds.feedburner.com/mactegaki?format=xml" # RDF1.0
#url = "http://simanman.hatenablog.com/feed"
#rss = Feed.get(url)
#Feed.show(rss)
