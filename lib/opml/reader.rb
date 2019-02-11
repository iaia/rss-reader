require 'oga'
require 'rss'

module Opml
  class Reader
    attr_reader :xml, :category

    def initialize(filepath)
      @category = {}
      @xml = File.open(filepath, &:read)
    end

    def self.read(filepath)
      reader = new(filepath)
      reader.read
      reader
    end

    def read
      # type=rss is rss
      get_element(read_outlines).each do |outline|
        if rss_node?(outline)
          add_rss(outline)
        else
          make_rss_with_category(outline)
        end
      end
    end

    def rss_node?(node)
      return false if node.attributes.length.zero?

      type = node.attribute('type')
      return false if type.nil?

      true if type.value == 'rss'
    end

    def make_rss_with_category(category_node)
      category = category_node.attribute('text').value
      get_element(category_node.children).each do |node|
        add_rss(node, category) if rss_node?(node)
      end
    end

    def get_element(nodes)
      nodes.select do |outline|
        outline.class == Oga::XML::Element
      end
    end

    def read_outlines
      # outline is category or rss
      document = Oga.parse_xml(@xml)
      document.xpath('//body/outline')
    end

    def add_rss(rss_node, category = 'uncategorized')
      @category[category] = [] unless @category.key?(category)
      @category[category] << RSS.new(rss_node.attribute('title').value,
                                     rss_node.attribute('htmlUrl').value,
                                     rss_node.attribute('xmlUrl').value,
                                     category)
    end
  end
end
