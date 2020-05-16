# frozen_string_literal: true

# Users can create new messages.
class Api::V1::MessagesController < ApplicationController
  # Each message must have a sender, a recipient, and a text message
  def create
    message = Message.new(message_params)
    if message.save
      render status: :created, json: {
        message: { id: message.id, timestamp: message.created_at }
      }
    else
      render status: :unprocessable_entity, json: {
        errors: message.errors.full_messages
      }
    end
  end

  # Get the messages (up to the maximum) for the given recipient
  # NOTE: Each recipient has only the most recent 30 days of messages
  MAXIMUM_MESSAGES = 100
  def index
    messages = filtered_recipient_messages
      .take(MAXIMUM_MESSAGES)
      .collect { |message| serialize_message(message) }
    render status: :ok, json: { messages: messages }
  rescue ActionController::ParameterMissing => e
    render status: :unprocessable_entity, json: { error: e.message }
  rescue ActiveRecord::RecordNotFound => e
    render status: :unprocessable_entity, json: {
      error: "recipient #{params[:recipient_id]} does not exist"
    }
  end

  private

  def message_params
    params.require(:message).permit(:sender_id, :recipient_id, :text)
  end

  def recipient
    @recipient ||= User.find(recipient_params)
  end

  def recipient_params
    params.require(:recipient_id)
  end

  def filtered_recipient_messages
    if params[:sender_id]
      recipient.messages.where(sender_id: params[:sender_id])
    else
      recipient.messages
    end
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
