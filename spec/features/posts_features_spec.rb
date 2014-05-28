require 'spec_helper'

def make_post
  visit '/posts/new'
  fill_in 'Title', with: 'Partay!'
  fill_in 'Description', with: "I don't know any of these people!"
end

describe 'first impressions' do
  
  context 'when a user arrives at the site for the first time' do

    specify 'they will be greeted with a welcome message and have the option to create a post' do
      visit '/posts'
      expect(page).to have_content "Welcome to MakerGram"
      expect(page).to have_link 'New Post'
    end

  end
end

describe 'creating a new post' do

  context 'when logged in' do

    before do
      user = User.create(email: 'random@stranger.com', password: 'password', password_confirmation: 'password')
      login_as user
    end

    specify 'with valid data' do
      make_post
      click_button 'Create Post'
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


  context 'when not logged in' do

    it 'takes us to the sign up page' do
      visit '/posts'
      click_link 'New Post'
      expect(page).to have_content 'Sign up'
    end

  end
end