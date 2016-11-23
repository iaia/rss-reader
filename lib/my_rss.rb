# encoding: utf-8

module MyRSS
    class RSS
        attr_accessor :title, :html_url, :xml_url, :category
        def initialize(title, html_url, xml_url, category = "uncategorized")
            @title, @html_url, @xml_url, @category = title, html_url, xml_url, category
        end
    end
end
