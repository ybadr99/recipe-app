require 'rails_helper'

RSpec.describe RecipeFoodsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { User.create(name: 'example', email: 'example@example.com', password: 'password') }
  let(:food) { Food.create(name: 'Food Item', measurement_unit: 'grams', price: 10.99, quantity: 100, user:) }
  let(:recipe) do
    Recipe.create(name: 'Recipe', description: 'Recipe Description', cooking_time: 60, preparation_time: 30,
      public: true, user:)
  end

  before { sign_in user }

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: { recipe_id: recipe.id }
      expect(response).to have_http_status(:success)
    end

    it 'assigns @recipe_food, @recipe, and @foods' do
      get :new, params: { recipe_id: recipe.id }
      expect(assigns(:recipe_food)).to be_a_new(RecipeFood)
      expect(assigns(:recipe)).to eq(recipe)
      expect(assigns(:foods)).to eq([food])
    end

    it 'renders the new template' do
      get :new, params: { recipe_id: recipe.id }
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new RecipeFood' do
        expect do
          post :create, params: { recipe_food: { quantity: 10, recipe_id: recipe.id, food_id: food.id } }
        end.to change(RecipeFood, :count).by(1)
      end

      it 'redirects to the created Recipe' do
        post :create, params: { recipe_food: { quantity: 10, recipe_id: recipe.id, food_id: food.id } }
        expect(response).to redirect_to(recipe_path(recipe))
      end

      it 'sets a notice flash message' do
        post :create, params: { recipe_food: { quantity: 10, recipe_id: recipe.id, food_id: food.id } }
        expect(flash[:notice]).to eq('Recipe Food was successfully created.')
      end
    end

    context 'with invalid params' do
      it 'does not create a new RecipeFood' do
        expect do
          post :create, params: { recipe_food: { quantity: -1, recipe_id: recipe.id, food_id: food.id } }
        end.not_to change(RecipeFood, :count)
      end

      it 're-renders the new template' do
        post :create, params: { recipe_food: { quantity: -1, recipe_id: recipe.id, food_id: food.id } }
        expect(response).to render_template(:new)
      end
    end
  end
end
