class CreateVisitors < ActiveRecord::Migration[6.0]
  def change
    create_table :visitors do |t|
      t.string :dni
      t.string :first_name
      t.string :last_name
      t.references :health, null: false, foreign_key: true
      t.references :security, null: false, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
