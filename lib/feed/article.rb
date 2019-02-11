module Feed
  class Article
    attr_accessor :title, :url, :published_time, :description, :content
    def initialize(title:, url:,
                   published_time: Time.now,
                   description:, content:)
      @title = title
      @url = url
      @published_time = published_time
      @description = description
      @content = content
    end
  end
end
