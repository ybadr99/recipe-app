require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  user = FactoryBot.create(:user)
  recipe = Recipe.new(user:, name: 'Recipe 1', description: 'Recipe 1 description', cooking_time: 1,
                      preparation_time: 1, public: true)
  food = Food.new(user:, name: 'Food 1', measurement_unit: 'kg', price: 1, quantity: 1)
  before { recipe.save && food.save }

  recipe_food = RecipeFood.new(recipe:, food:, quantity: 1)
  before { recipe_food.save }

  it 'is valid with valid attributes' do
    expect(recipe_food).to be_valid
  end

  it 'is not valid without a quantity' do
    recipe_food.quantity = nil
    expect(recipe_food).to_not be_valid
    expect(recipe_food.errors[:quantity]).to include("Quantity can't be blank")
  end

  it 'is not valid with a quantity less than 1' do
    recipe_food.quantity = 0
    expect(recipe_food).to_not be_valid
    expect(recipe_food.errors[:quantity]).to include('Quantity must be greater than 0')
  end

  it 'is valid with a quantity greater than 0' do
    recipe_food.quantity = 1
    expect(recipe_food).to be_valid
  end

  describe 'associations' do
    it 'belongs to recipe' do
      association = described_class.reflect_on_association(:recipe)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'belongs to food' do
      association = described_class.reflect_on_association(:food)
      expect(association.macro).to eq(:belongs_to)
    end
  end

  describe 'validations' do
    it 'validates presence of quantity' do
      recipe_food = RecipeFood.new
      expect(recipe_food.valid?).to be_falsey
      expect(recipe_food.errors[:quantity]).to include("Quantity can't be blank")
    end

    it 'validates presence of recipe' do
      recipe_food = RecipeFood.new
      expect(recipe_food.valid?).to be_falsey
      expect(recipe_food.errors[:recipe]).to include('must exist')
    end

    it 'validates presence of food' do
      recipe_food = RecipeFood.new
      expect(recipe_food.valid?).to be_falsey
      expect(recipe_food.errors[:food]).to include('must exist')
    end
  end
end
