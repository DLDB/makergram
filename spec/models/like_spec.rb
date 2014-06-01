require 'spec_helper'

describe Like do
  let(:user){ create(:user) }
  let(:post){ create(:post) }

  it 'adds a like' do
    Like.create(user_id: user.id, post_id: post.id)
    expect(post.likes.count).to eq 1
  end

  it 'can return all likes on a post' do
    kate = create(:user, email: 'kate@email.com')
    dan = create(:user, email: 'dan@email.com')
    Like.create(user_id: kate.id, post_id: post.id)
    Like.create(user_id: dan.id, post_id: post.id)
    expect(post.likes.count).to eq 2
    likers = post.likes.map do |like| 
      liker = User.find(like.user_id )
      liker.email
    end
    expect(likers).to eq ['kate@email.com', 'dan@email.com']
  end


end
