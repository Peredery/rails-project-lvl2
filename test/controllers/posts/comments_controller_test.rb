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
    attrs = {
      content: Faker::Lorem.sentence
    }

    patch post_comment_path(@post, @comment), params: {
      post_comment: attrs
    }

    assert { @comment.reload.content == attrs[:content] }
    assert_redirected_to post_path(@post)
  end

  test 'reply' do
    attrs = {
      content: Faker::Lorem.sentence,
      parent_id: @comment.id
    }

    assert_difference -> { PostComment.count } do
      post post_comments_path(@post), params: {
        post_comment: attrs
      }
    end

    assert { PostComment.find_by(content: attrs[:content]) }
    assert_redirected_to post_path(@post)
  end

  test 'delete' do
    delete post_comment_path(@post, @comment)

    assert { PostComment.find(@comment.id).deleted? }
    assert_redirected_to post_path(@post)
  end
end
