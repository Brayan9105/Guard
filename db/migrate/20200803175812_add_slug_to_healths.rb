class AddSlugToHealths < ActiveRecord::Migration[6.0]
  def change
    add_column :healths, :slug, :string
    add_index :healths, :slug, unique: true
  end
end
