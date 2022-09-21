# frozen_string_literal: true

class ApplicationController < ActionController::Base # rubocop:todo Style/Documentation
  def current_user
    User.first
  end
end
