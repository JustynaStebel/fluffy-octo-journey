require "rails_helper"

RSpec.describe "Articles", type: :request do
  let(:article) { create(:article) }

  describe "GET index" do
    subject(:index_request) { get articles_path }

    it { is_expected.to render_template(:index) }
  end

  describe "GET show" do
    subject(:show_request) { get article_path(article) }

    it { is_expected.to render_template(:show) }
  end

  describe "POST like" do
    subject(:like_request) { post article_like_path(article) }

    it "increases article likes count by 1" do
      expect { subject }.to change { article.likes.count }.from(0).to(1)
    end
  end
end