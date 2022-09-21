# frozen_string_literal: true

class AddUserRefToPosts < ActiveRecord::Migration[7.0] # rubocop:todo Style/Documentation
  def change
    add_reference :posts, :user, null: false, foreign_key: true
  end
end
