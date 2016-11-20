# encoding: utf-8

require "spec_helper"

describe "ReadOpmlTest" do
    before do
        filepath = File.dirname(__FILE__) + "/feedly.opml"
        @reader = ReadOpml::Reader.new(filepath)
    end

    describe "read opml" do
        before do
       end
        it "open opml" do
            expect(@reader.xml).to_not be_nil
        end
        it "get outlines under body" do
            outlines = @reader.get_outlines_under_body
            expect(outlines.length).to eq 7
        end

        it "get category" do
            @reader.get_category
            expect(@reader.category.length).to eq 3
        end

        it "get rss" do
            @reader.get_rss
            expect(@reader.rss.length).to eq 29
        end

#        it "read" do
#            categories = @reader.read
#            #            categories.each_pair do |category, sites|
#            #                #p category
#            #                sites.each do |site|
#            #                    #p "site_title: " + site["title"] + ", html_url:" + site["html_url"] + ", xml_url" + site["xml_url"]
#            #                end
#            #            end
#            expect(true).to be true
#        end
    end
end
