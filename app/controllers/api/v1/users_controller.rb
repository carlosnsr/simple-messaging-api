# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render status: :created, json: { user: { id: user.id }}
    else
      render status: :unprocessable_entity, json: {
        errors: user.errors.full_messages
      }
    end
  end

  def index
    render status: :ok, json: {
      users: User.all.collect{ |user| { id: user.id, name: user.name } }
    }
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
