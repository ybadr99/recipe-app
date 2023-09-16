# /spec/model/recip_spec.rb
require 'rails_helper'

RSpec.describe Recipe, type: :model do
  user = User.new(name: 'John Doe', email: 'local@host', password: '123456', password_confirmation: '123456')
  before { user.save }

  recipe = Recipe.new(user:, name: 'Recipe 1', description: 'Recipe 1 description', cooking_time: 1,
                      preparation_time: 1, public: true)
  before { recipe.save }

  it 'is valid with valid attributes' do
    expect(recipe).to be_valid
  end

  it 'is not valid without a name' do
    recipe.name = nil
    expect(recipe).to_not be_valid
    expect(recipe.errors[:name]).to include("Recipe name can't be blank")
  end

  it 'is not valid with a name less than 3 characters' do
    recipe.name = 'ab'
    expect(recipe).to_not be_valid
    expect(recipe.errors[:name]).to include('Recipe name is too short (minimum is 3 characters)')
  end

  it 'is valid with a name between 3 and 50 characters' do
    recipe.name = 'a' * 10
    expect(recipe).to be_valid
  end

  it 'is not valid with name that already exists' do
    recipe2 = Recipe.create(user_id: 1, name: 'Recipe 1', description: 'Recipe 1 description', cooking_time: 1,
                            preparation_time: 1, public: true)
    expect(recipe2).to_not be_valid
  end

  it 'is not valid without a description' do
    recipe.description = nil
    expect(recipe).to_not be_valid
    expect(recipe.errors[:description]).to include("Description can't be blank")
  end

  it 'is not valid with a description less than 10 characters' do
    recipe.description = 'a' * 9
    expect(recipe).to_not be_valid
    expect(recipe.errors[:description]).to include('Description is too short (minimum is 10 characters)')
  end

  it 'is not valid with a description more than 500 characters' do
    recipe.description = 'a' * 501
    expect(recipe).to_not be_valid
    expect(recipe.errors[:description]).to include('Description is too long (maximum is 500 characters)')
  end

  it 'is valid with a description less than 500 characters' do
    recipe.description = 'a' * 10
    expect(recipe).to be_valid
  end

  it 'is not valid without a cooking time' do
    recipe.cooking_time = nil
    expect(recipe).to_not be_valid
    expect(recipe.errors[:cooking_time]).to include("Cooking time can't be blank")
  end

  it 'is valid with a cooking time greater than 0' do
    recipe.cooking_time = 1
    expect(recipe).to be_valid
  end

  it 'is not valid without a preparation time' do
    recipe.preparation_time = nil
    expect(recipe).to_not be_valid
    expect(recipe.errors[:preparation_time]).to include("Preparation time can't be blank")
  end

  it 'is valid with a preparation time greater than 0' do
    recipe.preparation_time = 1
    expect(recipe).to be_valid
  end

  it 'is not valid without a public' do
    recipe.public = nil
    expect(recipe).to_not be_valid
    expect(recipe.errors[:public]).to include('is not included in the list')
  end

  it 'is valid with a public boolean value' do
    recipe.public = 1
    expect(recipe).to be_valid
    recipe.public = 0
    expect(recipe).to be_valid
  end

  it 'is not valid without a user' do
    recipe.user_id = nil
    expect(recipe).to_not be_valid
    expect(recipe.errors[:user]).to include('must exist')
  end

  it 'is not valid with a cooking time less than 1' do
    recipe.cooking_time = 0
    expect(recipe).to_not be_valid
    expect(recipe.errors[:cooking_time]).to include('must be greater than 0')
  end

  it 'is not valid with a preparation time less than 1' do
    recipe.preparation_time = 0
    expect(recipe).to_not be_valid
    expect(recipe.errors[:preparation_time]).to include('must be greater than 0')
  end
end
