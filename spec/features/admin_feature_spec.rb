require 'spec_helper'

describe 'An Admin' do
  
  it 'cannot sign up' do
    expect{visit '/admins/sign_up'}.to raise_error
  end


end