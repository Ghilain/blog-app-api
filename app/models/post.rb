# frozen_string_literal: true

class Post < ActiveRecord::Base # rubocop:todo Style/Documentation
  belongs_to :author
  has_many :comments
  has_many :likes
  after_save :update_posts_counter

  private

  def update_posts_counter
    author.increment!(:posts_counter)
  end

  public

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
