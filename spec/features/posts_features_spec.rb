require 'spec_helper'


describe 'first impressions' do
  
  context 'when a user arrives at the site for the first time' do

    specify 'they will be greeted with a welcome message' do
      visit '/posts'
      expect(page).to have_content "Welcome to MakerGram"
    end

  end
end

describe 'creating a new post' do

  context 'when logged in' do

    before do
      user = create :user
      login_as user, scope: :user
    end

    specify 'with valid data' do
      make_post
      attach_file 'Picture', Rails.root.join('spec/images/sadcucumber.jpg')
      fill_in 'Address', with: '25 City Road, London'
      click_button 'Create Post'
      expect(page).to have_css 'img.uploaded-pic'
      expect(current_path).to eq '/posts'
      expect(page).to have_content 'Partay!'

    end

    specify 'with invalid data' do
      visit '/posts/new'
      fill_in 'Title', with: ''
      fill_in 'Description', with: ''
      click_button 'Create Post'
      expect(page).to have_content 'error'
    end

    it 'adds a picture to the homepage' do
      make_post
      attach_file 'Picture', Rails.root.join('spec/images/sadcucumber.jpg')
      click_button 'Create Post'
      expect(page).to have_css 'img.uploaded-pic'
    end

  end


end

describe 'deleting a post' do
  context 'my own post' do

    before do
      dan = create(:user)
      login_as dan, scope: :user
      create(:post, user: dan)
    end

    it 'my post is removed from page' do
      visit '/posts'
      click_link 'x'
      expect(page).to have_content 'deleted'
    end

  end
  
  context "someone else's post" do
    before do
      dan = create :user
      kate = create(:user, email: 'kate@kate.com')
      create(:post, title: "kates pic", user: kate)
      login_as dan, scope: :user
    end

    specify 'there is no link to delete the post' do
    visit '/posts'
      expect(page).not_to have_link "Delete"
    end

  end
end

describe 'adding maps' do

  before do
    dan = create :user
    login_as dan, scope: :user
  end

  it 'can add an address to a post' do
    visit 'posts/new'
    make_post
    fill_in 'Address', with: '25 City Road, London'
    click_button 'Create Post'
    expect(page).to have_link 'Map'
  end

  it 'does not show a map button if post does not have an address' do
    create(:post)
    visit '/posts'
    expect(page).not_to have_link 'Map'
  end

  it 'shows the map when the map button is clicked' do
    create(:post, address: '25 City Road')
    visit '/posts'
    click_link 'Map'
    expect(page).to have_content('map')
  end
end