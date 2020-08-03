class AddSlugToVisitor < ActiveRecord::Migration[6.0]
  def change
    add_column :visitors, :slug, :string
    add_index :visitors, :slug, unique: true
  end
end
