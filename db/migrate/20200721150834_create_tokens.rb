class CreateTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :tokens do |t|
      t.string :name
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
