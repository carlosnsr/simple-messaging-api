# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render status: :created, json: { user: { id: user.id }}
    else
      render status: :unprocessable_entity,
        json: { errors: Array.wrap(user.errors) }
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
