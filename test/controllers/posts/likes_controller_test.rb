# frozen_string_literal: true

require 'test_helper'

class Posts::LikesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @post = posts(:one)
    @user = users(:one)

    sign_in @user
  end

  def test_create
    post post_likes_url(@post), as: :turbo_stream, xhr: true

    assert_response :success
  end

  def test_destroy
    assert_difference -> { PostLike.count }, -1 do
      delete post_like_url(@post, @post.likes.first), as: :turbo_stream, xhr: true
    end
  end
end
