module Deletable
  extend ActiveSupport::Concern

  included do
    has_one :deleted_entity, as: :deleted_entity, dependent: :destroy
  end

  def soft_delete!(user_id)
    build_deleted_entity(deleted_by: user_id).save
  end

  def deleted?
    deleted_entity.present?
  end
end
