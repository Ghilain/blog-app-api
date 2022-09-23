class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  validates :name, presence: true
  validates :posts_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  has_many :posts, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'

  after_save :add_jwt_token

  def add_jwt_token
    update_column(:authentication_token, ApiHelper::JsonWebToken.encode(email))
  end

  def recent_three_posts
    posts.order(created_at: :desc).limit(3)
  end
end
