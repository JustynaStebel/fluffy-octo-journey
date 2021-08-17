FactoryBot.define do
  factory :article do
    title { "Random title" }
    description { "Random description" }
    status { "active" }
    remote_id { 234837 }
  end
end