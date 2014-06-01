class LikesController < ApplicationController
  
  def create
 
    @post = Post.find(params[:format])
    @user = current_user
    @like = Like.new
    @post.likes << @like
    @user.likes << @like 
    @like.save
    
    redirect_to('/')
  end

end
