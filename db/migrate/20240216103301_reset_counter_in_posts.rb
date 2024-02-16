# frozen_string_literal: true

class ResetCounterInPosts < ActiveRecord::Migration[7.1]
  def change
    Post.find_each { |post| Post.reset_counters(post.id, :likes_count) }
  end
end
