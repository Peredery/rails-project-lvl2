module PostsHelper
  def owner?(post)
    post.creator_id == current_user&.id
  end
end
