class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 250 }
  belongs_to :author, class_name: 'User', foreign_key: 'author_id', counter_cache: true
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def recent_comments_on_post
    comments.order(created_at: :desc).limit(5)
  end

  def update_each_posts_count
    author.increment!(:posts_count)
  end
end
