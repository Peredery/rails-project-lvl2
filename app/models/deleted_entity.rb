# == Schema Information
#
# Table name: deleted_entities
#
#  id                  :integer          not null, primary key
#  deleted_by          :integer
#  deleted_entity_type :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  deleted_entity_id   :integer          not null
#
# Indexes
#
#  index_deleted_entities_on_deleted_entity  (deleted_entity_type,deleted_entity_id)
#
class DeletedEntity < ApplicationRecord
  belongs_to :deleted_entity, polymorphic: true
  belongs_to :user, foreign_key: :deleted_by
end
