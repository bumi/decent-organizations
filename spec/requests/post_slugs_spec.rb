require "rails_helper"

RSpec.describe "Post Slugs", :type => :request do
  describe 'change of slug' do
    let(:post) { FactoryBot.create(:post_with_categories) }

    it 'redirects to new URL if the slug was changed' do
      original_path = post_path(post)
      post.title = 'My title changed'
      post.save
      get original_path
      expect(response).to redirect_to(post_path(post))
    end
  end
end
