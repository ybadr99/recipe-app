require 'rails_helper'

RSpec.describe 'Foods', type: :request do
  include Devise::Test::IntegrationHelpers

  before do
    @user = User.create(name: 'dieum', email: 'test@gmail.com', password: '123456')
    sign_in @user
  end

  describe 'GET /index' do
    before do
      get '/foods'
    end

    it 'returns a success response' do
      expect(response).to have_http_status(:success)
    end

    it 'displays the index template' do
      expect(response).to render_template(:index)
    end

    it 'includes "Food" in the response body' do
      expect(response.body).to include('Food')
    end
  end

  describe 'GET /new' do
    before do
      get '/foods/new'
    end

    it 'returns a success response' do
      expect(response).to have_http_status(:success)
    end

    it 'displays the new template' do
      expect(response).to render_template(:new)
    end

    it 'includes "Food" in the response body' do
      expect(response.body).to include('Food')
    end
  end

end
