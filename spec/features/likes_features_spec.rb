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
      expect(page).to have_css '.like_button', text: '♥ 1'
    end

end