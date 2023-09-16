# Tests for the Recipes new page
# spec/integration/Recipes/new_spec.rb

require 'rails_helper'

RSpec.describe 'recipes/new', type: :feature do
  before(:each) do
    @user = FactoryBot.create(:user)
    sign_in(@user, scope: :user)
  end

  it 'renders the new Recipes page' do
    visit new_recipe_path
    expect(page).to have_content('Add New Recipe')
  end

  it 'creates a new recipe' do
    visit new_recipe_path

    fill_in :name => 'recipe[name]', with: 'recipe name'
    fill_in :id => 'recipe_description', with: 'recipe description'
    fill_in :id => 'recipe_preparation_time', with: 10
    fill_in :id => 'recipe_cooking_time', with: 10

    click_on 'Create Recipe'

    expect(page) .to have_current_path(recipes_path)
  end
end
