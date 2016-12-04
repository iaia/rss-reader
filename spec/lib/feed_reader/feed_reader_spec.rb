# encoding: utf-8

require "spec_helper"
require "feed_reader/feed_reader"

describe "FeedReaderTest" do
    before do
    end
    describe "atom11 feed reader test" do
        before do
        end
        it "read" do
            url = "http://iaiaie.blogspot.com/feeds/posts/default" # atom atom11
            site = FeedReader::Reader.read(url)
            expect(site).not_to be_nil
            expect(site.rss_type).to eq RSS::Atom::Feed
        end
    end

    describe "atom10 feed reader test" do
        before do
        end
        it "read" do
            url = "http://blog.livedoor.jp/nicovip2ch/atom.xml" # 壊れたatom atom10
            site = FeedReader::Reader.read(url)
            expect(site).not_to be_nil
            expect(site.rss_type).to eq RSS::Atom::Feed
        end
    end

    describe "rss2.0 feed reader test" do
        before do
        end
        it "read" do
            url = "http://ie.u-ryukyu.ac.jp/news-ie/feed/" # rss2.0 rss20
            site = FeedReader::Reader.read(url)
            expect(site.rss_type).to eq RSS::Rss
            expect(site.version).to eq "2.0"
        end
    end

    describe "rdf1.0 feed reader test" do
        before do
        end
        it "read" do
            url = "http://feeds.feedburner.com/mactegaki?format=xml" # RDF1.0
            site = FeedReader::Reader.read(url)
            expect(site.rss_type).to eq RSS::RDF
            expect(site.version).to eq "1.0"
        end
    end
end
