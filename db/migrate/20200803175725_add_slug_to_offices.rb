class AddSlugToOffices < ActiveRecord::Migration[6.0]
  def change
    add_column :offices, :slug, :string
    add_index :offices, :slug, unique: true
  end
end
