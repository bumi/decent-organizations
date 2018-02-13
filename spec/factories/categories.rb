FactoryBot.define do
  factory :category do
    sequence :name do |n|
      "Category #{n}"
    end
  end
end
