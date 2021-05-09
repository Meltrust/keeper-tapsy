require 'rails_helper'

RSpec.describe User, type: :model do
  let(:testuser1) { User.create(name: 'user1', email: 'usertest1@mail.com', password: 'password') }
  let(:testuser2) { User.create(name: 'user2', email: 'usertest2@mail.com', password: 'password') }
  let(:invalid_user) { User.create(name: nil, email: 'notvalid@email.com', password: 'password') }

  describe 'User can be validated' do
    it 'Validates user' do
      expect(testuser1).to be_valid
    end

    it 'Unvalidates user if not valid' do
      expect(invalid_user).to_not be_valid
    end

    describe 'friendship requests' do
      it 'User can accept friends' do
        testuser1.friendships.create(friend_id: testuser2.id)
        testuser2.confirm_friend(testuser1)
        friends = testuser1.friend?(testuser2)

        expect(friends).to eq(true)
      end
      it 'User can submit friend requests' do
        testuser1.friendships.create(friend_id: testuser2.id)

        expect(testuser1.pending_friends.size).to eq(1)
      end
    end
  end
end
