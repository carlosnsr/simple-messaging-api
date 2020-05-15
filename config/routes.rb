# frozen_string_literal: true

Rails.application.routes.draw do
  resources :messages, only: [:create, :index]

  resources :recipients, only: [] do
    resources :messages, only: [:index]
  end
end
