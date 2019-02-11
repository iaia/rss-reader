class Site < ActiveRecord::Base
  has_many :articles
  has_many :site_users
  has_many :users, through: :site_users
  belongs_to :collection

  attr_accessor :unread_num

  def self.add(user, url)
    reader = Feed::Feed.read(url)
    return if reader.nil?

    collection = user.collections.find_or_create_by(name: 'uncategorized')
    site = user.sites.create(name: reader.site_feed.title, url: reader.site_feed.url, feed_url: url, collection_id: collection.id)
  end

  def self.preview(url)
    reader = Feed::Feed.read(url)
    return if reader.nil?

    Site.new(name: reader.site_feed.title, url: reader.site_feed.url, feed_url: url)
  end

  def update_site_articles
    reader = Feed::Feed.read(feed_url)
    return if reader.nil?

    reader.site_feed.articles.each do |article_feed|
      article = Article.find_or_create_by(
        url: article_feed.url,
        site_id: id
      ) do |_article|
        _article.title = article_feed.title
        _article.published = article_feed.published_time
        _article.description = article_feed.description
        _article.content = article_feed.content
        _article.save
      end
    end
  end
end
