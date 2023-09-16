# /spec/model/food_spec.rb
require 'rails_helper'

RSpec.describe Food, type: :model do
  user = FactoryBot.create(:user)

  food = Food.new(user: user, name: 'Food 1', measurement_unit: 'kg', price: 1, quantity: 1)
  before { food.save }

  it 'is valid with valid attributes' do
    expect(food).to be_valid
  end

  it 'is not valid without a name' do
    food.name = nil
    expect(food).to_not be_valid 
    expect(food.errors[:name]).to include("Food name can't be blank")
  end

  it 'is not valid with a name less than 3 characters' do
    food.name = 'ab'
    expect(food).to_not be_valid
    expect(food.errors[:name]).to include('Food name is too short (minimum is 3 characters)')
  end

  it 'is not valid with a name more than 50 characters' do
    food.name = 'a' * 51
    expect(food).to_not be_valid
    expect(food.errors[:name]).to include('Food name is too long (maximum is 50 characters)')
  end

  it 'is valid with a name between 3 and 50 characters' do
    food.name = 'a' * 10
    expect(food).to be_valid
  end

  it 'is not valid without a measurement_unit' do
    food.measurement_unit = nil
    expect(food).to_not be_valid
    expect(food.errors[:measurement_unit]).to include("Measurement unit can't be blank")
  end

  it 'is not valid with a measurement_unit less than 2 characters' do
    food.measurement_unit = 'a'
    expect(food).to_not be_valid
    expect(food.errors[:measurement_unit]).to include('Measurement unit is too short (minimum is 2 characters)')
  end

  it 'is not valid with a measurement_unit more than 10 characters' do
    food.measurement_unit = 'a' * 11
    expect(food).to_not be_valid
    expect(food.errors[:measurement_unit]).to include('Measurement unit is too long (maximum is 10 characters)')
  end
  
  it 'is valid with a measurement_unit between 2 and 10 characters' do
    food.measurement_unit = 'a' * 5
    expect(food).to be_valid
  end

  it 'is not valid without a price' do
    food.price = nil
    expect(food).to_not be_valid
    expect(food.errors[:price]).to include("Price can't be blank")
  end

  it 'is not valid with a price 0' do
    food.price = 0
    expect(food).to_not be_valid
    expect(food.errors[:price]).to include('Price must be greater than 0')
  end

  it 'is not valid with a price less than 0' do
    food.price = -1
    expect(food).to_not be_valid
    expect(food.errors[:price]).to include('Price must be greater than 0')
  end

  it 'is not valid with a price greater than 1000' do
    food.price = 1001
    expect(food).to_not be_valid
    expect(food.errors[:price]).to include('Price must be less than 1000')
  end
  
  it 'is not valid with a price that is not a number' do
    food.price = 'a'
    expect(food).to_not be_valid
    expect(food.errors[:price]).to include('Price is not a number')
  end

  it 'is valid with a price between 0 and 1000' do
    food.price = 1
    expect(food).to be_valid
  end

  it 'is not valid without a quantity' do
    food.quantity = nil
    expect(food).to_not be_valid
    expect(food.errors[:quantity]).to include("Quantity can't be blank")
  end

  it 'is not valid with a quantity 0' do
    food.quantity = 0
    expect(food).to_not be_valid
    expect(food.errors[:quantity]).to include('Quantity must be greater than 0')
  end

  it 'is not valid with a quantity less than 0' do
    food.quantity = -1
    expect(food).to_not be_valid
    expect(food.errors[:quantity]).to include('Quantity must be greater than 0')
  end

  it 'is not valid with a quantity greater than 1000' do
    food.quantity = 1001
    expect(food).to_not be_valid
    expect(food.errors[:quantity]).to include('Quantity must be less than 1000')
  end

  it 'is not valid with a quantity that is not a number' do
    food.quantity = 'a'
    expect(food).to_not be_valid
    expect(food.errors[:quantity]).to include('Quantity must be a number')
  end

  it 'is valid with a quantity between 0 and 1000' do
    food.quantity = 1
    expect(food).to be_valid
  end
end
