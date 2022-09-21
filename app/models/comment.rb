# frozen_string_literal: true

class Comment < ActiveRecord::Base # rubocop:todo Style/Documentation
  belongs_to :author
  belongs_to :post
  after_save :update_comments_counter

  private

  def update_comments_counter
    author.increment!(:comments_counter)
  end
end
