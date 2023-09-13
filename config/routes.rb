# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'home#index'

  resources :foods, only: [:index, :destroy, :new, :create]

  resources :recipes do
    resources :recipe_foods, only: %i[create destroy]
  end
end


