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

  def invitation_btn(user)
    return unless current_user != user

    return if current_user.friend?(user)

    if current_user.pending_friends.include?(user)
      'Invite pending'
    else
      link_to('Add Friend?', user_friendships_path(user_id: user.id), method: :post, class: 'profile-link')
    end
  end

  def accept_friendship(friendship)
    show_user = User.find_by(id: params[:id])
    (return unless current_user == show_user)

    # link_to('Accept?', user_friendship_path(user_id: friendship.id), method: :put, class: 'profile-link')
    link_to('Accept friend?', user_friendship_path(user_id: friendship.user.id), method: :put, class: 'profile-link')
  end

  def reject_friendship(friendship)
    show_user = User.find_by(id: params[:id])
    (return unless current_user == show_user)

    # link_to('Reject?', user_friendship_path(user_id: friendship.id), method: :delete, class: 'profile-link')
    link_to('Reject?', user_friendship_path(user_id: friendship.user.id), method: :delete, class: 'profile-link')
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
