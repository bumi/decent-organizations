FactoryBot.define do
  factory :comment do
    text "MyText"
    name "Commenter name"
    association :post, factory: :post_with_categories
  end
end
