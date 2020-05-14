require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a name' do
    user = User.create(name: 'Name')
    expect(user.reload.name).to eq('Name')
  end
end
