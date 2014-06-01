class AddLikeToPosts < ActiveRecord::Migration
  def change
    add_reference :posts, :like, index: true
  end
end
