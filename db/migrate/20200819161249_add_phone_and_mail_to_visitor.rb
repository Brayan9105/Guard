class AddPhoneAndMailToVisitor < ActiveRecord::Migration[6.0]
  def change
    add_column :visitors, :email, :string
    add_column :visitors, :phone, :string
  end
end
