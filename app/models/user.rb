# frozen_string_literal: true

# Represents a user of the messaging app.
# Each user has messages that have been sent to them,
class User < ApplicationRecord
  has_many :messages,
    # only the most recent 30 days' worth of messages
    -> { where(created_at: 30.days.ago..).order(created_at: :desc) },
    foreign_key: :recipient_id

  validates :name, presence: true
end
