module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post)
    end
  end

  def current_user_or_friend?(user)
    current_user == user || current_user.friend?(user)
  end

  def invitation_btn(user)
    return if current_user_or_friend?(user)

    if user.pending_friendship?(current_user)
      'Invite pending'
    else
      unless current_user.pending_friendship?(user)
        link_to('Add Friend?', user_friendships_path(user_id: user.id), method: :post, class: 'profile-link')
      end
    end
  end

  def accept_friendship_with_user(user)
    return if current_user_or_friend?(user)
    return unless current_user.pending_friendship?(user)

    friendship = current_user.pending_friendship(user)
    link_to('Accept', user_friendship_path(friendship.user, friendship.id), method: :put, class: 'profile-link')
  end

  def reject_friendship_with_user(user)
    return if current_user_or_friend?(user)
    return unless current_user.pending_friendship?(user)

    friendship = current_user.pending_friendship(user)
    link_to('Reject', user_friendship_path(friendship.user, friendship.id), method: :delete, class: 'profile-link')
  end

  def accept_friendship(friendship)
    (return unless current_user == @user)

    link_to('Accept', user_friendship_path(friendship.user, friendship.id), method: :put, class: 'profile-link')
  end

  def reject_friendship(friendship)
    (return unless current_user == @user)

    link_to('Reject', user_friendship_path(friendship.user, friendship.id), method: :delete, class: 'profile-link')
  end

  def friendship_flag(user)
    "#{user.name} is already your friend" if current_user.friends.include?(user)
  end

  def friendship_flag_index(user)
    if current_user.friends.include?(user)
      friendship_flag(user)
    else
      user.name
    end
  end
end
