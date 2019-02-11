class FeedController < ApplicationController
  before_action :auth, :update_articles

  def index; end

  def new; end

  def preview
    @url = params[:add_feed][:url]
    @site = Site.preview(@url)
    @articles = Article.preview(@url)
  end

  def add
    Site.add(@user, params[:url])
    redirect_to action: 'index'
  end

  def site
    @site = Site.find(params[:id])
    @articles = @site.articles.where(read: false)
    render action: 'index'
  end
end
