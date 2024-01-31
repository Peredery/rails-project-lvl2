class CreateDeletedEntities < ActiveRecord::Migration[7.1]
  def change
    create_table :deleted_entities do |t|
      t.integer :deleted_by
      t.references :deleted_entity, polymorphic: true, null: false

      t.timestamps
    end
  end
end
