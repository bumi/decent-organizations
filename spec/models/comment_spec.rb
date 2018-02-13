require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject(:comment) { FactoryBot.build(:comment) }

  it 'is valid with valid attributes' do
    expect(comment).to be_valid
  end

  it 'is saved with valid attributes' do
    expect(comment.save).to be true
  end

  it 'is not valid without a post' do
    comment.post = nil
    expect(comment).not_to be_valid
  end

  it 'is not valid without text' do 
    comment.text = nil
    expect(comment).not_to be_valid
  end

  it 'is not valid with too long text' do 
    comment.text = "a" * 1001
    expect(comment).not_to be_valid
  end

  it 'is not valid with too short text' do 
    comment.text = "a" * 4
    expect(comment).not_to be_valid
  end
end
