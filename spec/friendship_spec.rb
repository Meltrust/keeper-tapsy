RSpec.describe Friendship, type: :model do
  let(:testuser1) { User.create(name: 'testuser1', email: 'testuser1@testmail.com', password: 'password') }
  let(:testuser2) { User.create(name: 'testuser2', email: 'testuser2@testmail.com', password: 'password') }
  let(:new_friendship) { Friendship.create(user: testuser1, friend: testuser2) }
  let(:new_invalid_friendship) { Friendship.create(user: testuser1) }

  describe 'Friendships functionality' do
    it 'Sets default value of false to confirmed' do
      expect(new_friendship.confirmed).to be(false)
    end
    it 'Validates friendship' do
      expect(new_friendship).to be_valid
      expect(testuser1.friendships.size).to eq(1)
    end
    it 'Unvalidates frienship if not valid' do
      expect(new_invalid_friendship.valid?).to be(false)
    end
    it 'Knows if a user has friends' do
      new_friendship.confirmed = true
      new_friendship.save
      expect(testuser1.friends.size).to eq(1)
    end
    it 'Knows if user have no friends' do
      new_friendship.save
      expect(testuser1.friends.size).to eq(0)
    end
    it 'Creates 2 rows of friendships' do
      new_friendship.save
      expect(Friendship.all.length).to eq(2)
    end
    it 'Verifies creation of inverse friendship' do
      new_friendship.save
      expect(Friendship.where(user: new_friendship.friend, friend: new_friendship.user)).not_to be_nil
    end
  end
end
