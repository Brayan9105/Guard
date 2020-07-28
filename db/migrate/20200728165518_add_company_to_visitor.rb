class AddCompanyToVisitor < ActiveRecord::Migration[6.0]
  def self.up
    add_column :visitors, :company, :string

  end
end
