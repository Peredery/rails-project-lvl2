# frozen_string_literal: true

module ApplicationHelper
  def categories
    @categories ||= Category.all
  end
end
