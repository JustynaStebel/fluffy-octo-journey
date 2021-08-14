class ArticlesController < ApplicationController
  def index
    ArticlesImportJob.perform_now
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def like
    @article = Article.find(params[:article_id])
    @article.likes.create()
    redirect_to articles_path
  end
end