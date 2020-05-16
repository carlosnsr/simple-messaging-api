# frozen_string_literal: true

Rails.application.routes.draw do
  concern :recent_messagable do
    resources :messages, only: :index
  end

  concern :api_base do
    resources :messages, only: [:create, :index]
    resources :users, only: :create

    resources :recipients, only: [], concerns: :recent_messagable do
      resources :senders, only: [], concerns: :recent_messagable
    end
  end

  namespace :api do
    namespace :v1 do
      concerns :api_base
    end
  end
end
