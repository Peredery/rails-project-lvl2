# frozen_string_literal: true

class AddLikesCountToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :likes_count, :integer
  end
end
