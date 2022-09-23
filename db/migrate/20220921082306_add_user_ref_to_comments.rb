# frozen_string_literal: true

class AddUserRefToComments < ActiveRecord::Migration[7.0] # rubocop:todo Style/Documentation
  def change
    add_reference :comments, :user, null: false, foreign_key: true
  end
end
