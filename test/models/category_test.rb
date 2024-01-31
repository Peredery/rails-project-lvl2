# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def test_soft_delete_comment
    comment = post_comments(:with_comments)
    assert_not comment.deleted?

    comment.soft_delete!(users(:one).id)
    assert comment.deleted?
  end
end
