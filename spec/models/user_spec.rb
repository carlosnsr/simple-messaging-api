require 'rails_helper'

RSpec.describe User, type: :model do
  context 'new user' do
    let(:user) { User.new(name: 'Name') }
    it 'has a name' do
      expect(user).to have_attributes(name: 'Name')
    end

    it 'has no messages' do
      expect(user.messages).to eq([])
    end
  end

  context 'user with messages' do
    let(:user) { create(:user) }
    let!(:message_today) { create(:message, recipient: user) }
    let!(:message_yesterday) do
      create(:message, recipient: user) do |message|
        message.created_at = 1.day.ago
        message.save
      end
    end

    it 'has messages' do
      expect(user.messages).not_to be_empty
    end

    it 'has only messages sent to them' do
      create(:message)
      expect(user.messages.count).to eq(2)
      expect(user.messages.all? { |msg| msg.recipient == user }).to be_truthy
    end

    it 'has no messages sent by them to others' do
      create_list(:message, 3, sender: user) # sent
      expect(user.messages.none? { |msg| msg.sender == user }).to be_truthy
    end

    it 'has messages ordered by most recent' do
      expect(user.messages.to_a).to eq([message_today, message_yesterday])
    end

    it 'excludes messages that are older than 30 days' do
      create(:message, recipient: user) do |message|
        message.created_at = 31.days.ago
        message.save
      end
      expect(user.messages.to_a).to eq([message_today, message_yesterday])
    end

    it 'can see messages they sent to themselves' do
      self_msg = create(:message, recipient: user, sender: user)
      expect(user.messages.any? { |msg| msg.id == self_msg.id }).to be_truthy
    end
  end
end
