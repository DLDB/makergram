class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post].permit(:title, :description, :picture))
    @post.user = current_user
    if @post.save
      redirect_to('/posts')
    else
      render 'new'
    end
  end

  def destroy
    @post = current_user.posts.find params[:id]
    @post.destroy
    flash[:notice]='Successfully deleted!'
  rescue ActiveRecord::RecordNotFound
    flash[:alert]='HAXXXX!!!! This is not your post!'
  ensure
    redirect_to '/posts'
  end

end
