# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, :controllers => { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :articles

  resources :articles do
    resources :comments, only: %i[create destroy]
    resources :likes, only: %i[create destroy]
  end

  root 'articles#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
