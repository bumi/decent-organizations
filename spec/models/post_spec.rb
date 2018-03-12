require 'rails_helper'

RSpec.describe Post, type: :model do
  subject(:post) { FactoryBot.build(:post_with_categories) }

  it 'is valid with valid attributes' do
    expect(post).to be_valid
  end

  it 'is saved with valid attributes' do
    expect(post.save).to be true
  end

  it 'is not valid without a title' do
    post.title = nil
    expect(post).not_to be_valid
  end

  it 'is not valid if the title is too long' do
    post.title = "a" * 256
    expect(post).not_to be_valid
  end

  it 'is not valid if the title is too short' do
    post.title = "a" * 5
    expect(post).not_to be_valid
  end

  it 'is not valid without a description' do
    post.description = nil
    expect(post).not_to be_valid
  end

  it 'is not valid if the description is too long' do
    post.description = "a" * 1001
    expect(post).not_to be_valid
  end

  it 'is not valid if the description is too short' do
    post.description = "a" * 39
    expect(post).not_to be_valid
  end

  it 'is not valid without an url' do
    post.url = nil
    expect(post).not_to be_valid
  end

  it 'is not valid with a malformed URL' do
    post.url = "htp:/aasdasd"
    expect(post).not_to be_valid
  end

  it 'is not valid with a too long URL' do
    post.url = "h" * 256
    expect(post).not_to be_valid
  end

  it 'is not valid wihtout a category' do
    post.categories = []
    expect(post).not_to be_valid
  end

  it 'is not valid with a negative upvotes count' do
    post.upvotes = -1
    expect(post).not_to be_valid
  end

  it 'is not valid with a non-integer passed for upvotes' do
    post.upvotes = 2.5
    expect(post).not_to be_valid
  end

  describe '#valid_url' do
    let(:empty_post) { described_class.new }

    it 'it refuses an URL without a protocol' do
      empty_post.url = 'example.com'
      expect(empty_post.valid_url).to include("Provided URL must be a valid URL")
    end

    it 'it allows a valid URL' do
      empty_post.url = 'https://example.com'
      expect(empty_post.valid_url).to be nil
    end
  end

  describe 'slug' do
    let(:post) { FactoryBot.create(:post_with_categories) }

    it 'updates the slug if the name was changed' do
      new_title = "New title for post"
      post.title = new_title
      post.save

      expect(post.slug).to eq(new_title.parameterize)
    end

    it 'creates a slug if the slug is blank' do
      original_slug = post.slug
      post.slug = nil
      post.save

      expect(post.slug).to eq(original_slug)
    end
  end

  describe '#related_posts' do
    let(:first_category) { FactoryBot.create(:category, name: 'blogs') }
    let(:second_category) { FactoryBot.create(:category, name: 'articles') }
    let(:original_post) { FactoryBot.create(:post_with_categories, categories: [first_category]) }
    let(:posts) { FactoryBot.create_list(:post_with_categories, 3) }

    context 'no related posts available' do

      it 'returns an empty collection if no related posts were found' do
        expect(original_post.related_posts).to eq([])
      end

    end

    context 'less then three relaced posts available' do

      it 'returns less posts if less then three related are available' do
        posts.first.categories << first_category
        expect(original_post.related_posts).to eq([posts.first])
      end
      
    end

    context 'three or more related posts available' do
      before do
        posts.each { |post| post.categories << first_category }
      end

      it 'returns three related posts if at least three are available' do
        additional_post = FactoryBot.create(:post_with_categories, categories: [first_category])
        expect(original_post.related_posts.length).to eq(3)
      end

      it 'does not include the original post in the collection' do
        expect(original_post.related_posts).not_to include(original_post)
      end

      it 'does not return duplicate posts' do
        posts.first.categories =[FactoryBot.create(:category)]
        posts.second.categories << second_category
        original_post.categories << second_category
        expect(original_post.related_posts.map(&:id)).to satisfy("only include distinct post IDs") do |ids_array|
          ids_array.length == ids_array.uniq.length
        end
      end

    end

    context 'related posts for multiple matching categories' do
      before do
        original_post.categories << second_category
        posts.first.categories << first_category
        posts.second.categories << second_category
        posts.third.categories << second_category
      end

      it 'find related posts with just one of the original categories matching' do
        expect(original_post.related_posts).to match_array(posts)
      end
    end
  end
end
