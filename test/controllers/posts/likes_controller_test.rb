# frozen_string_literal: true

require 'test_helper'

class Posts::LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @user = users(:one)

    sign_in @user
  end

  test 'create' do
    post post_likes_url(@post), as: :html

    assert_redirected_to @post
  end

  test 'destroy' do
    assert_difference -> { PostLike.count }, -1 do
      delete post_like_url(@post, @post.likes.first), as: :turbo_stream, xhr: true
    end
  end
end
