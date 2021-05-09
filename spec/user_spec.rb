require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user1) { User.create(name: 'user1', email: 'usertest1@mail.com', password: 'password') }
  let(:user2) { User.create(name: 'user2', email: 'usertest2@mail.com', password: 'password') }
  let(:invalid_user) { User.create(name: nil, email: 'notvalid@email.com', password: 'password') }

  describe 'User can be validated' do
    it 'Validates user' do
      expect(user1).to be_valid
    end

    it 'Unvalidates user if not valid' do
      expect(invalid_user).to_not be_valid
    end
  end
end
