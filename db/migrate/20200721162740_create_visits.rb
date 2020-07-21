class CreateVisits < ActiveRecord::Migration[6.0]
  def change
    create_table :visits do |t|
      t.integer :in_temperature
      t.integer :out_temperature
      t.integer :status, default: 0
      t.references :visitor, null: false, foreign_key: true
      t.references :floor, null: false, foreign_key: true
      t.references :office, null: false, foreign_key: true
      t.references :token, null: false, foreign_key: true

      t.timestamps
    end
  end
end
