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
        expect(post.tags).to be_empty

      end

    end

    context 'with one tag' do

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

    context 'multiple tags' do

      it 'adds each tag to the post' do
        post.tag_names = 'yolo, swag'
        expect(post.tags.count).to eq 2
      end

      it 'reuses tags if they exist' do
        post.tag_names = 'yolo, swag'
        create( :post, title: 'cucumber').tag_names = 'yolo'
        expect(Tag.count).to eq 2
      end

      it 'will not attach multiple duplicate tags to a post' do
        post.tag_names = 'yolo, swag, yolo'
        expect(post.tags.count).to eq 2
      end

    end

  end

end
