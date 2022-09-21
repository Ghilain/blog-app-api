# frozen_string_literal: true

class RemoveUserId < ActiveRecord::Migration[7.0] # rubocop:todo Style/Documentation
  def change
    remove_column :posts, :user_id, :bigint
    remove_column :likes, :user_id, :bigint
    remove_column :comments, :user_id, :bigint
  end
end
