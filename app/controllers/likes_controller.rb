class LikesController < ApplicationController
  def create
    @user = current_user
    @post = Post.includes(:author).find(params[:post_id])

    @already_liked = Like.where(author: @user, post: @post)
    destroy && return if @already_liked.present?

    @like = Like.create(likes_params_to_like)
    @like.author = @user
    @like.post = @post

    flash[:notice] = if @like.save
                       'Liked!'
                     else
                       'Failed try again'
                     end
    redirect_back_or_to user_post_path(@post.author, @post)
  end

  def destroy
    @like = current_user.likes.last
    @like.destroy
    @post = @like.post
    flash[:notice] = 'Unliked.'
    redirect_back_or_to user_post_path(@post.author, @post)
  end

  private

  def likes_params_to_like
    params.permit(:author_id, :id)
  end
end
