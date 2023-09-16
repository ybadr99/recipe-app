# Tests for the Foods index page
# spec/integration/foods/index_spec.rb

require 'rails_helper'

RSpec.describe 'foods/index', type: :feature do
  before(:each) do
    @user = FactoryBot.create(:user)
    sign_in(@user, scope: :user)

    @food1 = Food.create(user: @user, name: 'apple', measurement_unit: 'unit', price: 5, quantity: 10)
    @food2 = Food.create(user: @user, name: 'beans', measurement_unit: 'kg', price: 9, quantity: 5)
  end

  it 'renders the Foods page' do
    visit foods_path
    expect(page).to have_content('Foods List')
    expect(page).to have_content(@food1.name)
    expect(page).to have_content(@food1.measurement_unit)
    expect(page).to have_content(@food1.price)

    expect(page).to have_content(@food2.name)
    expect(page).to have_content(@food2.measurement_unit)
    expect(page).to have_content(@food2.price)
  end
end
