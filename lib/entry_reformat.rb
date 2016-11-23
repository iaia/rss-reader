# encoding: utf-8
require 'oga'

module EntryReformat
    class << self
        def reformat(html_text)
            html_text = remove_attributes(html_text)
            # html_text = add_attributes(html_text)
            return html_text
        end
        def remove_attributes(html_text)
            parser = Oga.parse_html(html_text)
            parser = read_node(parser)
            html_text = parser.to_xml
            return html_text
        end

        def read_node(node)
            node.children.each do |n|
                class_name = n.class
                if class_name == Oga::XML::Element 
                    n = read_element(n)
                    n = read_node(n)
                elsif class_name == Oga::XML::Text 
                else
                end
            end
            return node
        end

        def read_element(node)
            return node if node.attributes.length == 0
            if node.name == "a" or node.name == "img"
                remove_link_tag(node)
            else
                node.attributes = []
            end
            node 
        end
        def remove_link_tag(node)
            node.attributes.delete_if do |attr|
                if attr.name != "src" and attr.name != "href"
                    true
                else
                    false
                end
            end
        end
    end
end

#html_text = File.open("../../memo/test.html", &:read)
#html_text = EntryReformat.reformat(html_text)
#p html_text
