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
                    attr_html_url = ""
                    n.attributes.each do |attr|
                        if attr.name == "text"
                            attr_text = attr.value
                        elsif attr.name == "title"
                            attr_title = attr.value
                        elsif attr.name == "type"
                            attr_type = attr.value
                        elsif attr.name == "xmlUrl"
                            attr_xml_url = attr.value
                        elsif attr.name == "htmlUrl"
                            attr_html_url = attr.value
                        end
                    end
                    if attr_type == "rss" and attr_xml_url != ""
                        # uncategorized
                        category_name = "uncategorized"
                        site = Hash.new
                        site["title"] = attr_title
                        site["html_url"] = attr_html_url
                        site["xml_url"] = attr_xml_url
                        @category[category_name].push(site)
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
            sites = []

            if node.children.length == 0
                node.attributes.each do |attr|
                    if attr.name == "xmlUrl"
                        urls.push(attr.value)
                    end
                end
            end
            node.children.each do |n|
                if n.class == Oga::XML::Element
                    site = Hash.new
                    n.attributes.each do |attr|
                        if attr.name == "xmlUrl"
                            # 親要素を取り出して、そのvalueの名前になっている配列に追加
                            site["xml_url"] = attr.value
                        elsif attr.name == "htmlUrl"
                            site["html_url"] = attr.value
                        elsif attr.name == "title"
                            site["title"] = attr.value
                        end
                    end
                    if site["xml_url"] != ""
                        sites.push(site)
                    end
                end
            end
            return sites
        end
    end
end

#xml = File.open("feedly.opml", &:read)
#reader = ReadOpml::Reader.new(xml)
#categories = reader.read
#categories.each_pair do |category, sites|
#    p category
#    sites.each do |site|
#        p "site_title: " + site["title"] + ", html_url:" + site["html_url"] + ", xml_url" + site["xml_url"]
#    end
#    p ""
#end
