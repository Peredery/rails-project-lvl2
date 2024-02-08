# frozen_string_literal: true

require 'test_helper'

class Posts::CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @user = users(:one)
    @comment = post_comments(:with_comments)

    sign_in @user
  end
  test 'update' do
    patch post_comment_path(@post, @comment), params: {
      post_comment: {
        content: Faker::Lorem.sentence
      }
    }

    assert_redirected_to post_path(@post)
  end

  def test_reply
    assert_difference -> { PostComment.count } do
      post post_comments_path(@post), params: {
        post_comment: {
          content: Faker::Lorem.sentence,
          parent_id: @comment.id
        }
      }
    end

    assert_redirected_to post_path(@post)
  end

  def test_delete
    delete post_comment_path(@post, @comment)
    assert_redirected_to post_path(@post)
  end
end
