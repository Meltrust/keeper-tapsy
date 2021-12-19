class Api::V1::CommentsController < ApplicationController
  protect_from_forgery with: :null_session
  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    render json: @comments
  end

  def create
    post = Post.find(params[:post_id])
    comment = post.comments.build(user_id: current_user.id, content: params[:content])

    if comment.save
      render json: comment
    else
      render plain: 'comment not created', status: :bad_request, message: 'comment not created'
    end
  end
end
