class AddSlugToFloors < ActiveRecord::Migration[6.0]
  def change
    add_column :floors, :slug, :string
    add_index :floors, :slug, unique: true
  end
end
