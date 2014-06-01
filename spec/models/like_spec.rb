require 'spec_helper'

describe Like do
  let(:user){ create(:user) }
  let(:post){ create(:post) }

  it 'adds a like' do
    Like.create(user_id: user.id, post_id: post.id)
    expect(post.likes.count).to eq 1
  end

end
