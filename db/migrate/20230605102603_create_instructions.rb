class CreateInstructions < ActiveRecord::Migration[7.0]
  def change
    create_table :instructions do |t|
      t.references :order_process, null: false, foreign_key: true
      t.string :process_instructions
      t.string :comments
      t.string :name
      t.integer :status
      t.string :sheet_name

      t.timestamps
    end
  end
end
