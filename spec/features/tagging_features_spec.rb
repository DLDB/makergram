require 'spec_helper'

describe 'tagging posts' do
  before do
    dan = create(:user)
    login_as dan  
  end

  it 'displays the tags on the posts page' do
    make_post
    fill_in 'Tags', with: 'yolo, swag'
    click_button 'Create Post'
    expect(page).to have_link '#yolo'
    expect(page).to have_link '#swag'
  end



end