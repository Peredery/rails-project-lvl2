require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  def test_show
    get post_path(posts(:one))
    assert_response :success
  end

  def test_new
    sign_in users(:one)
    get new_post_path
    assert_response :success
  end

  def test_create
    sign_in users(:one)
    post posts_path, params: {
      post: {
        title: Faker::Lorem.sentence,
        body: Faker::Lorem.characters(number: 200),
        category_id: categories(:one).id
      }
    }
    assert_redirected_to post_path(Post.last)
  end

  def test_update
    sign_in users(:one)
    patch post_path(posts(:one)), params: {
      post: {
        title: Faker::Lorem.sentence,
        body: Faker::Lorem.characters(number: 200),
        category_id: categories(:one).id
      }
    }

    assert_redirected_to post_path(posts(:one))
  end

  def test_update_wrong_user
    sign_in users(:two)
    patch post_path(posts(:one)), params: {
      post: {
        title: Faker::Lorem.sentence,
        body: Faker::Lorem.characters(number: 200),
        category_id: categories(:one).id
      }
    }

    assert_response :not_found
  end

  def test_destroy
    sign_in users(:one)
    assert_changes -> { Post.count }, -1 do
      delete post_path(posts(:one))
    end
    assert_redirected_to root_path
  end
end
