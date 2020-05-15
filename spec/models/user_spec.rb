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
    before do
      create_list(:message, 3, recipient: user) # received
      create_list(:message, 2, sender: user) # sent
      create(:message) # unrelated
    end

    it 'has messages' do
      expect(user.messages).not_to be_empty
    end

    it 'has only messages sent to them' do
      expect(user.messages.count).to eq(3)
      expect(user.messages.all? { |msg| msg.recipient == user }).to be_truthy
    end

    it 'has no messages sent by them to others' do
      expect(user.messages.none? { |msg| msg.sender == user }).to be_truthy
    end

    it 'can see messages they sent to themselves' do
      self_msg = create(:message, recipient: user, sender: user)
      expect(user.messages.any? { |msg| msg.id == self_msg.id }).to be_truthy
    end
  end
end
