require 'spec_helper'
require 'opml/reader'

describe 'Reader Test' do
  before do
    @filepath = File.dirname(__FILE__) + '/feedly.opml'
  end

  describe 'read opml' do
    before do
      @reader = Opml::Reader.new(@filepath)
    end

    it 'open opml' do
      expect(@reader.xml).to_not be_nil
    end

    it 'get outlines under body' do
      outlines = @reader.read_outlines
      expect(outlines.length).to eq 7
    end

    it 'get rss' do
      @reader.read
      expect(@reader.category['uncategorized'].length).to eq 4
    end
  end
  describe 'read' do
    it 'read' do
      @reader = Opml::Reader.read(@filepath)
      p @reader.category
      expect(@reader.category.class).to eq Hash
    end
  end
end
