require 'spec_helper'

describe 'a user can "like" a post' do
  
  context 'with no likes' do
    before do 
      user = create( :user )
      visit '/'
      login_as user
      make_post
      click_button 'Create Post'
    end

    specify 'a user can "like" a post' do
      click_link 'Like'
      expect(Like.count).to eq 1
      click_link 'Like'
      expect(Like.count).to eq 2
      expect(page).to have_content '2'
    end



  end

end