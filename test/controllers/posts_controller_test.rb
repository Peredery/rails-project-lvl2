# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @user = users(:one)

    sign_in @user
  end

  test 'show' do
    get post_path(@post)
    assert_response :success
  end

  test 'new' do
    get new_post_path
    assert_response :success
  end

  test 'create' do
    post posts_path, params: {
      post: {
        title: Faker::Lorem.sentence,
        body: Faker::Lorem.characters(number: 200),
        category_id: categories(:one).id
      }
    }
    assert_redirected_to post_path(Post.last)
  end

  test 'update' do
    patch post_path(@post), params: {
      post: {
        title: Faker::Lorem.sentence,
        body: Faker::Lorem.characters(number: 200)
      }
    }

    assert_redirected_to post_path(posts(:one))
  end

  test 'update_wrong_user' do
    sign_in users(:two)
    patch post_path(@post), params: {
      post: {
        title: Faker::Lorem.sentence,
        body: Faker::Lorem.characters(number: 200)
      }
    }

    assert_response :not_found
  end

  test 'destroy' do
    assert_changes -> { Post.count }, -1 do
      delete post_path(posts(:one))
    end
    assert_redirected_to root_path
  end
end
