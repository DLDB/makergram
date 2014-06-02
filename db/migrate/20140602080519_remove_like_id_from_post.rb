class RemoveLikeIdFromPost < ActiveRecord::Migration
  def change
    remove_column :posts, :like_id
  end
end
