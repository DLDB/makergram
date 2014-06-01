require 'spec_helper'

describe Post do
  let(:post){ create(:post)}

  context 'when validating a post' do

    specify 'there must be a title that is at least 3 characters long' do
      failpost = Post.new(title: nil)
      expect(failpost).to have(1).error_on(:title)
    end

  end

  describe '#tag_names=' do

    context 'no tags' do

      it 'does nothing' do
        post.tag_names = ' '
        puts "tags: #{post.tags.each.to_a}"
        expect(post.tags).to be_empty

      end

    end

    context 'with tags' do

      it 'adds a single tag' do
        post.tag_names = 'yolo'
        expect(post.tags.count).to eq 1
      end

      it 'prepends tag with #' do
        post.tag_names = 'yolo'
        tag = post.tags.last
        expect(tag.name).to eq '#yolo'
      end

      it 'does not double up the #' do
        post.tag_names = '#yolo'
        tag = post.tags.last
        expect(tag.name).to eq '#yolo'
      end

    end

  end

end
