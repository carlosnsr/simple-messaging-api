# frozen_string_literal: true

# Users can create new messages.
class MessagesController < ApplicationController
  # Each message must have a sender, a recipient, and a text message
  def create
    message = Message.new(message_params)
    if message.save
      render status: :created, json: {
        message: { id: message.id, timestamp: message.created_at }
      }
    else
      render status: :unprocessable_entity, json: message.errors
    end
  rescue ActionController::ParameterMissing => e
    render status: :unprocessable_entity, json: { error: e.message }
  end

  private

  def message_params
    params.require(:message).require(:sender_id)
    params.require(:message).require(:recipient_id)
    params.require(:message).require(:text)

    params.require(:message).permit(:sender_id, :recipient_id, :text)
  end
end
