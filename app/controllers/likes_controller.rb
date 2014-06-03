class LikesController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    @user = current_user
    Like.create(user: @user, post: @post)
    WebsocketRails[:likes].trigger 'new', { id: @post.id, new_like_count:@post.likes.count }
    redirect_to('/')
  end



end
