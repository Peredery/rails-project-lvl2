# frozen_string_literal: true

module PostsHelper
  def owner?(model)
    model.is_a?(Post) ? model.creator_id == current_user&.id : model.user_id == current_user&.id
  end
end
