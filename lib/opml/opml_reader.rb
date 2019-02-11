require 'opml_reader'

filepath = '/Users/iaia/work/src/ruby/gems/opml_reader/spec/feedly.opml'
reader = OpmlReader::OpmlReader.read(filepath)
reader.categories.each do |category|
  category.rss.each do |rss|
    p "#{category.name}/#{rss.title} (#{rss.xml_url})"
  end
end
