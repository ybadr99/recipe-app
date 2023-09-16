# spec/models/food_spec.rb
require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:user) { User.create(name: 'John Doe', email: 'john@example.com', password: 'password') }

  it 'is valid with valid attributes' do
    food = Food.new(
      name: 'Sample Food',
      measurement_unit: 'grams',
      price: 10.99,
      quantity: 100,
      user:
    )
    expect(food).to be_valid
  end

  it 'is not valid without a name' do
    food = Food.new(
      measurement_unit: 'grams',
      price: 10.99,
      quantity: 100,
      user:
    )
    expect(food).to_not be_valid
  end

  it 'is not valid with a name shorter than 3 characters' do
    food = Food.new(
      name: 'A',
      measurement_unit: 'grams',
      price: 10.99,
      quantity: 100,
      user:
    )
    expect(food).to_not be_valid
  end

  it 'is not valid with a name longer than 50 characters' do
    food = Food.new(
      name: 'A' * 51,
      measurement_unit: 'grams',
      price: 10.99,
      quantity: 100,
      user:
    )
    expect(food).to_not be_valid
  end

  # Add similar tests for other attributes (measurement_unit, price, quantity)

  it 'is not valid without a user' do
    food = Food.new(
      name: 'Sample Food',
      measurement_unit: 'grams',
      price: 10.99,
      quantity: 100
    )
    expect(food).to_not be_valid
    expect(food.errors[:user]).to include('must exist')
  end
end
