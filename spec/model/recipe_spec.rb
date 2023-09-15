# /spec/model/recipe_spec.rb

require 'rails_helper'

RSpec.describe Recipe, type: :model do
  user = User.new(name: 'John Doe', email: 'local@host.com', password: '123456', password_confirmation: '123456')
  before { user.save }

  recipe = Recipe.new(user: user, name: 'Recipe 1', description: 'Recipe 1 description', cooking_time: 1,
                      preparation_time: 1, public: true)
  before { recipe.save }

  it 'is valid with valid attributes' do
    expect(recipe).to be_valid
  end
  
end