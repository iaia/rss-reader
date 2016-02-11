# encoding: utf-8
require 'oga'

module ReadOpml
    class Reader
        attr_reader :category
        def initialize(xml)
            @xml = xml
        end
        def read
            @category = Hash.new
            document = Oga.parse_xml(@xml)
            read_node(document)
            return @category
        end
        def read_node(node)
            @category["uncategorized"] = []
            node.children.each do |n|
                class_name = n.class
                if class_name == Oga::XML::Element
                    category_name = ""
                    attr_text = ""
                    attr_type = ""
                    attr_title = ""
                    attr_xml_url = ""
                    n.attributes.each do |attr|
                        if attr.name == "text"
                            attr_text = attr.value
                        elsif attr.name == "title"
                            attr_title = attr.value
                        elsif attr.name == "type"
                            attr_type = attr.value
                        elsif attr.name == "xmlUrl"
                            attr_xml_url = attr.value
                        end
                    end
                    if attr_type == "rss" and attr_xml_url != ""
                        # uncategorized
                        category_name = "uncategorized"
                        @category[category_name].push(attr_xml_url)
                    elsif attr_text != "" and attr_title != "" 
                        # categorized
                        # valueを取り出してhashに空の配列入れる
                        category_name = attr_title
                        @category[category_name] = get_site(n)
                    end
                    if category_name == ""
                        read_node(n)
                    end
                else
                end
            end
        end
        def get_site(node)
            urls = []

            if node.children.length == 0
                node.attributes.each do |attr|
                    if attr.name == "xmlUrl"
                        urls.push(attr.value)
                    end
                end
            end
            node.children.each do |n|
                if n.class == Oga::XML::Element
                    n.attributes.each do |attr|
                        if attr.name == "xmlUrl"
                            # 親要素を取り出して、そのvalueの名前になっている配列に追加
                            urls.push(attr.value)
                        end
                    end
                end
            end
            return urls
        end
    end
end

#xml = File.open("feedly.opml", &:read)
#reader = ReadOpml::Reader.new(xml)
#categories = reader.read
#categories.each_pair do |category, sites|
#    p category
#    sites.each do |site|
#        p site
#    end
#    p ""
#end
