# frozen_string_literal: true

require 'test_helper'

class Posts::CommentsControllerTest < ActionDispatch::IntegrationTest
  def test_update
    sign_in users(:one)
    patch post_comment_path(posts(:one), post_comments(:with_comments)), params: {
      post_comment: {
        content: Faker::Lorem.sentence
      }
    }

    assert_redirected_to post_path(posts(:one))
  end

  def test_reply
    sign_in users(:one)

    assert_difference -> { PostComment.count } do
      post post_comments_path(posts(:one)), params: {
        post_comment: {
          content: Faker::Lorem.sentence,
          parent_id: post_comments(:with_comments).id
        }
      }
    end

    assert_redirected_to post_path(posts(:one))
  end

  def test_delete
    sign_in users(:one)
    delete post_comment_path(posts(:one), post_comments(:with_comments))
    assert_redirected_to post_path(posts(:one)), 'Comment deleted successfully'
  end
end
