# frozen_string_literal: true

require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  test 'show' do
    get category_path(categories(:one).name)
    assert_response :success
  end
end
