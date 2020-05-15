# frozen_string_literal: true

Rails.application.routes.draw do
  concern :api_base do
    resources :messages, only: [:create, :index]

    resources :recipients, only: [] do
      resources :messages, only: [:index]
    end
  end

  namespace :api do
    namespace :v1 do
      concerns :api_base
    end
  end
end
