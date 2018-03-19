require "rails_helper"

RSpec.describe "Category Slugs", :type => :request do
  describe 'change of slug' do
    let(:category) { FactoryBot.create(:category) }

    it 'redirects to new URL if the slug was changed' do
      original_path = category_path(category)
      category.name = 'My name changed'
      category.save
      get original_path
      expect(response).to redirect_to(category_path(category))
    end
  end
end
