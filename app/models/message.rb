# frozen_string_literal: true

# Represents a message between two users, belonging to each
class Message < ApplicationRecord
  belongs_to :recipient, class_name: 'User'
  belongs_to :sender, class_name: 'User'
end
