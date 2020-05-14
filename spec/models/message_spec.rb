# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:sender) { build(:user) }
  let(:recipient) { build(:user) }
  let(:text) { FFaker::HipsterIpsum.phrase }

  it 'has a sender, recipient, and text' do
    message = Message.new(
      sender: sender,
      recipient: recipient,
      text: text
    )
    expect(message).to have_attributes(
      sender: sender,
      recipient: recipient,
      text: text
    )
  end
end
