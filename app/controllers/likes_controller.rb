class LikesController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    @user = current_user
    Like.create(user: @user, post: @post)
    WebsocketRails[:likes].trigger 'new', { id: @post.id, new_like_count:@post.likes.count }
    redirect_to('/')
  end

  def show
  end

  def destroy
    @user = current_user
    @post = Post.find(params[:post_id])
    @like = @user.likes.find_by(post_id: @post.id)
    @like.destroy
    WebsocketRails[:likes].trigger 'new', { id: @post.id, new_like_count:@post.likes.count }
  end

end
