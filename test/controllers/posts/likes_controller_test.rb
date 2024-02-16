# frozen_string_literal: true

require 'test_helper'

class Posts::LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @user = users(:one)

    sign_in @user
  end

  test 'create' do
    sign_in users(:two)

    post post_likes_url(@post), as: :turbo_stream

    assert { @post.likes.find_by(user: users(:two)) }
  end

  test 'destroy' do
    delete post_like_url(@post, @post.likes.first), as: :turbo_stream

    assert { @post.likes.find_by(user: @user).nil? }
  end
end
