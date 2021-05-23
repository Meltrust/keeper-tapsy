class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.new(friend_id: params[:user_id])

    if @friendship.save
      redirect_to users_path, notice: 'Friend invited!'
    else
      redirect_to users_path, alert: 'Could not invite this user'
    end
  end

  def update
    # friend = User.find(params[:user_id])
    friend = User.find_by(id: params[:user_id])
    current_user.confirm_friend(friend)
    redirect_to user_path, notice: "#{friend.name} is your friend now!"
  end

  def destroy
    friend = User.find_by(id: params[:user_id])
    current_user.reject_friend(friend)
    redirect_to user_path, notice: "Your rejected #{friend.name}'s friend request."
  end
end
