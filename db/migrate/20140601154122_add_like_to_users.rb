class AddLikeToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :like, index: true
  end
end
