class CreateHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :histories do |t|
      t.references :order, null: false, foreign_key: true
      t.references :instruction, null: false, foreign_key: true
      t.jsonb :fields

      t.timestamps
    end
  end
end
