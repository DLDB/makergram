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
      click_button 'like'
      expect(page).to have_content 'likes this post'
      expect(page).to have_button 'unlike'
    end

  end

end