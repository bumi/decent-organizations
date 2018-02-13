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

end
