class Api::V1::PostsController < ApplicationController
  def index
    @post = Post.all

    render json: @post
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
