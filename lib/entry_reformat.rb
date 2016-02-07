# encoding: utf-8
require 'oga'

module EntryReformat
    def self.reformat(html_text)
        html_text = remove_attributes(html_text)
        # html_text = add_attributes(html_text)
        return html_text
    end
    def self.remove_attributes(html_text)
        parser = Oga.parse_html(html_text)
        parser = read_node(parser)
        html_text = parser.to_xml
        return html_text
    end

    def self.read_node(node)
        node.children.each do |n|
            class_name = n.class
            if class_name == Oga::XML::Element 
                if n.attributes.length > 0
                    # a, imgは無視
                    if n.name == "a" or n.name == "img"
                        n.attributes.delete_if do |attr|
                            if attr.name != "src" and attr.name != "href"
                                true
                            else
                                false
                            end
                        end
                    else
                        n.attributes = []
                    end
                end
                n = read_node(n)
            elsif class_name == Oga::XML::Text 
            else
            end
        end
        return node
    end
end

#html_text = File.open("../../memo/test.html", &:read)
#html_text = EntryReformat.reformat(html_text)
#p html_text
