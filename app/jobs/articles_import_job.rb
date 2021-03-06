require 'open-uri'

class ArticlesImportJob < ApplicationJob
  queue_as :default

  def perform

    url = "https://s3-eu-west-1.amazonaws.com/olio-staging-images/developer/test-articles-v4.json"
    imported_articles = JSON.parse(open(url).read)

    imported_articles.each do |imported_article|
      next unless imported_article["id"].present?

      article = Article.where(remote_id: imported_article["id"]).first_or_initialize
      article.title = imported_article["title"]
      article.likes_count = imported_article["reactions"]["likes"]
      article.description = imported_article["description"]
      article.status = imported_article["status"]
      article.image = imported_article["images"][0]["files"]["medium"]

      article.save

    end

    imported_articles
  end
end