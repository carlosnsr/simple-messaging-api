# frozen_string_literal: true

# Represents a user of the messaging app.
# Each user has messages that have been sent to them.
class User < ApplicationRecord
  has_many :messages, foreign_key: :recipient_id
end
