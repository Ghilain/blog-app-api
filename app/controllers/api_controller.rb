class ApiController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :authenticate_user!

  def list_all_post_of_user
    authentication_token = params[:authentication_token]
    return unless validate_user_token(authentication_token)

    posts = Post.where(author_id: params[:user_id])
    render json: posts, status: ok
  end

  def list_of_all_comments_post
    authentication_token = params[:authentication_token]
    return unless validate_user_token(authentication_token) && validate_post_params

    comments = Comment.where(post_id: params[:post_id], author_id: params[:user_id])

    render json: comments, status: ok
  end

  def add_comment
    authentication_token = params[:authentication_token]
    return unless validate_user_token(authentication_token)

    post_id = params[:post_id]
    text = params[:text]
    return unless validate_comment_params(text)

    comment = Comment.new(text:, author: @current_user, post_id:)
    if comment.save
      render json: comment, status: ok
    else
      render json: { error: 'Comment creation failed.' }, status: 500
    end
  end

  private

  def validate_comment_params(text)
    if !validate_post_params || text.nil? || text.empty?
      render json: { error: 'Can\'t create comment.' }, status: 400
      false
    else
      true
    end
  end

  def validate_post_params
    if Post.where(id: params[:post_id], author_id: params[:user_id]).exists?
      true
    else
      render json: { error: 'Post not exist.' }, status: 404
      false
    end
  end

  def validate_user_token(authentication_token)
    if authentication_token.nil?
      render json: { error: 'Invalid token.' }, status: 400
      false
    elsif !authenticate(authentication_token)
      render json: { error: 'Unauthorized.' }, status: 401
      false
    elsif !User.exists?(params[:user_id])
      render json: { error: 'User not exist' }, status: 404
      false
    else
      true
    end
  end

  def authenticate(authentication_token)
    email = ApiHelper::JsonWebToken.decode(authentication_token)[0]
    user = User.find_by(email:)
    return false if user.nil?

    @current_user = user
    true
  end
end
