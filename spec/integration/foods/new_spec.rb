# Tests for the Foods new page
# spec/integration/foods/new_spec.rb

require 'rails_helper'

RSpec.describe 'foods/new', type: :feature do
  before(:each) do
    @user = FactoryBot.create(:user)
    sign_in(@user, scope: :user)
  end

  it 'renders the new Foods page' do
    visit new_food_path
    expect(page).to have_content('Add New Food')
  end

  it 'creates a new food' do
    visit new_food_path

    fill_in id: 'food_name', with: 'Food 1'
    fill_in id: 'food_measurement_unit', with: 'unit'
    fill_in id: 'food_price', with: 10.00
    fill_in id: 'food_quantity', with: 10

    click_on 'Create Food'

    expect(page).to have_current_path(foods_path)
  end
end
