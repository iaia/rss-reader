# encoding: utf-8
require 'oga'
require "my_rss"

module ReadOpml
    class Reader
        attr_reader :xml, :category
        include MyRSS

        def initialize(filepath)
            @category = Hash.new
            @xml = File.open(filepath, &:read)
        end

        def self.read(filepath)
            reader = self.new(filepath)
            reader.read
            reader
        end

        def read
            get_rss
        end

        def get_category 
            # type=rssで無いものはカテゴリ
            @category = get_outlines_under_body().map do |outline| # node
                outline.attribute("title").value if outline.attribute("type").nil?
            end
            @category.compact!
        end

        def get_rss
            # type=rssがrss
            # 親がいればカテゴリ
            @category["uncategorized"] = []
            get_outlines_under_body().each do |outline|
                if outline.attribute("type")
                    @category["uncategorized"] << make_rss_object(outline) if outline.attribute("type").value == "rss"
                else
                    get_rss_under_category(outline, outline.attribute("text").value)
                end
            end
        end

        def get_rss_under_category(category_node, category)
            category_name = category_node.attribute("title").value
            @category[category_name] = category_node.children.map do |node|
                next if node.class != Oga::XML::Element
                next if node.attribute("type").nil?
                make_rss_object(node, category) if node.attribute("type").value == "rss"
            end
            @category[category_name].compact!
        end

        def get_outlines_under_body
            # outlineはカテゴリまたはrss
            document = Oga.parse_xml(@xml)
            document.xpath("//body/outline")
        end

        def make_rss_object(rss_node, category = "uncategorized")
            RSS.new(rss_node.attribute("title").value, rss_node.attribute("htmlUrl").value,
                    rss_node.attribute("xmlUrl").value, category)
        end
    end
end

