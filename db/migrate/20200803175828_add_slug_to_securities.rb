class AddSlugToSecurities < ActiveRecord::Migration[6.0]
  def change
    add_column :securities, :slug, :string
    add_index :securities, :slug, unique: true
  end
end
