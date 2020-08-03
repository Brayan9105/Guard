class AddSlugToTokens < ActiveRecord::Migration[6.0]
  def change
    add_column :tokens, :slug, :string
    add_index :tokens, :slug, unique: true
  end
end
