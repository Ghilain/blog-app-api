class CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    @comment = Comment.create(new_comment_params)
    @comment.post = post
    @comment.author = current_user
    if @comment.save
      flash[:notice] = 'New comment successfully.'
      redirect_to user_post_path(post.author, post)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def new_comment_params
    params.permit(:text)
  end
end
