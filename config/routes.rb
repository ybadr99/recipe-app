# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'home#index'

  resources :recipes do
    resources :recipe_foods, only: %i[new create edit update destroy]
  end

  resources :foods do
    resources :recipe_foods, only: %i[new create edit update destroy]
  end

  get '/general_shopping_list', to: 'recipes#shopping_list', as: 'general_shopping_list'
  get '/toggle_public/:id', to: 'recipes#toggle_public', as: 'toggle_public'
end
