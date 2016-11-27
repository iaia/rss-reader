# encoding: utf-8

require "spec_helper"
require "read_opml"

describe "ReadOpmlTest" do
    before do
    end

    describe "read opml" do
        before do
            p "before"
            filepath = File.dirname(__FILE__) + "/feedly.opml"
            @reader = ReadOpml::Reader.new(filepath)
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
            expect(@reader.category["uncategorized"].length).to eq 4
        end
    end
end
