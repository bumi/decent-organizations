FactoryBot.define do
  factory :post do
    title "My Title"
    description "Description of the post that is long enough to be valid."
    url "https://example.com"

    factory :post_with_categories do
      transient do
        categories_count 2
      end

      # Add categories to post
      after(:build) do |post, evaluator|
        
        post.categories << create_list(:category, evaluator.categories_count)
      end
    end
  end
end
