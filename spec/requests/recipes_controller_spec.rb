require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  include Devise::Test::IntegrationHelpers

  before do
    @user = User.create(name: 'dieum', email: 'test@gmail.com', password: '123456')
    sign_in @user
  end

  describe 'GET /recipes' do
    before do
      get '/recipes'
    end

    it 'returns a success response' do
      expect(response).to have_http_status(:success)
    end

    it 'displays the index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /recipes/new' do
    before do
      get '/recipes/new'
    end

    it 'returns a success response' do
      expect(response).to have_http_status(:success)
    end

    it 'displays the new template' do
      expect(response).to render_template(:new)
    end

    it 'includes "Create Recipe" in the response body' do
      expect(response.body).to include('Create Recipe')
    end
  end

  # You can add more test cases for other actions like show, create, edit, etc.
end
