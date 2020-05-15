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

  # Get all the messages for the given recipient
  def index
    messages = recipient.messages.collect { |message| serialize_message(message) }
    render status: :ok, json: { messages: messages }
  rescue ActiveRecord::RecordNotFound => e
    render status: :unprocessable_entity,
      json: { error: "recipient #{params[:recipient_id]} does not exist" }
  end

  private

  def message_params
    params.require(:message).require(:sender_id)
    params.require(:message).require(:recipient_id)
    params.require(:message).require(:text)

    params.require(:message).permit(:sender_id, :recipient_id, :text)
  end

  def recipient
    @recipient ||= User.find(recipient_params)
  end

  def recipient_params
    params.require(:recipient_id)
  end

  def serialize_message(message)
    {
      sender_id: message.sender.id,
      recipient_id: message.recipient.id,
      text: message.text,
      timestamp: message.created_at
    }
  end
end
