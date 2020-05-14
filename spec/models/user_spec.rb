require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a name' do
    user = User.new(name: 'Name')
    expect(user).to have_attributes(name: 'Name')
  end
end
