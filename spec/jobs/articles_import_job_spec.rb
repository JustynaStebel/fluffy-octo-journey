require "rails_helper"
require "json"

RSpec.describe ArticlesImportJob do
  subject(:result) { described_class.new.perform }
  # it is probably not the best idea to use the original link here but I found it easier/quicker than
  # copy/paste/format everything into the fixture (see fixtures as an example)
  let(:url) { "https://s3-eu-west-1.amazonaws.com/olio-staging-images/developer/test-articles-v4.json" }
  let(:articles) { JSON.parse(open(url).read) }
  let(:remote_id) { articles.first["id"] }

  it "queues on medium" do
    expect(described_class.queue_as).to match(/default\z/)
  end

  describe "#perform" do
    it "imports articles" do
      # naive expectations as I knew how many articles there were, in normal circumstances it would need to
      # be tested differently, e.g. whether the response is successful
      expect { subject }.to change(Article.all, :count).by(25)
    end

    describe "saving to the database" do
      before do
        subject
      end

      it "saves articles to the database" do
        expect(Article.first.title).to eq articles.first["title"]
        expect(Article.first.description).to eq articles.first["description"]
        expect(Article.first.status).to eq articles.first["status"]
        expect(Article.first.image).to eq articles.first["images"][0]["files"]["medium"]
        expect(Article.first.likes_count).to eq articles.first["reactions"]["likes"]
      end

      it "saves only unique articles" do
        expect(Article.where(remote_id: remote_id).count).to eq 1
      end
    end

    # describe "when job fails" do
      # not sure how to test it :sob:
      # I think it would be much easier if there was an argument passed
    # end
  end
end