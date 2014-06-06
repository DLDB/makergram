require 'spec_helper'

describe Like do
  let(:user){ create(:user) }
  let(:post){ create(:post) }

  it 'adds a like' do
    Like.create(user_id: user.id, post_id: post.id)
    expect(post.likes.count).to eq 1
  end

  it 'can delete a like', js:true do
    like = create(:like, user: user, post: post)
    login_as user, scope: :user
    visit '/posts'
    find('.unlike_button').click
    sleep 5
    expect(post.likes.count).to eq 0
  end

end
