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
require "test_helper"

class DeletedEntityTest < ActiveSupport::TestCase

end
