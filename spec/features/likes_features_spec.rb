require 'spec_helper'

describe 'liking posts' do
  
 before do
      user = create :user
      login_as user, scope: :user

    end

    specify 'likes count will be incremented', js:true do
      make_post
      click_button 'Create Post'
      expect(current_path).to eq '/posts'
      expect(page).to have_content 'Partay!'
      click_link '♥ 0'
      sleep(3)
      expect(Like.count).to eq 1
      expect(page).to have_css '.btn.btn-default.unlike_button', text: '♥ 1'
    end

    it 'can return all likes on a post' do
    kate = create(:user, email: 'kate@email.com')
    dan = create(:user, email: 'dan@email.com')
    post = create(:post, user: dan)
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