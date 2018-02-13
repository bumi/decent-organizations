FactoryBot.define do
  factory :comment do
    text "MyText"
    association :post, factory: :post_with_categories
  end
end
