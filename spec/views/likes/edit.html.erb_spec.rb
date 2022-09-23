require 'rails_helper'

RSpec.describe 'likes/edit', type: :view do
  before(:each) do
    @like = assign(:like, Like.create!)
  end

  it 'renders the edit like form' do
    render

    assert_select 'form[action=?][method=?]', like_path(@like), 'post' do # rubocop:todo Lint/EmptyBlock
    end
  end
end
