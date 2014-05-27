require 'spec_helper'

describe Post do

  context 'when validating a post' do

    specify 'there must be a title that is at least 3 characters long' do
      post = Post.new(title: nil)
      expect(post).to have(1).error_on(:title)
    end

  end

end
