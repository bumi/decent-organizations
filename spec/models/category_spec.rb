require 'rails_helper'

RSpec.describe Category, type: :model do
  subject(:category) { FactoryBot.build(:category) }

  it 'is valid with valid attributes' do
    expect(category).to be_valid
  end

  it 'is saved with valid attributes' do
    expect(category.save).to be true
  end

  it 'is not valid without a name' do
    category.name = nil
    expect(category).not_to be_valid
  end

  it 'is not valid with a too long name' do
    category.name = "a" * 256
    expect(category).not_to be_valid
  end

  it 'is not valid with a too long description' do
    category.description = "a" * 1001
    expect(category).not_to be_valid
  end

  it 'is not valid with a duplicate name' do
    unique_categroy = FactoryBot.create(:category)
    duplicate_category = FactoryBot.build(:category, name: unique_categroy.name)
    expect(duplicate_category).not_to be_valid
  end

  describe 'slug' do
    let!(:category) { FactoryBot.create(:category) }

    it 'updates the slug if the name was changed' do
      new_name = 'cars'
      category.name = new_name
      category.save

      expect(category.slug).to eq(new_name.parameterize)
    end
  end
end
