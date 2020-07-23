class AddAddressAndPhoneToSecurities < ActiveRecord::Migration[6.0]
  def change
    add_column :securities, :address, :string
    add_column :securities, :phone, :string
  end
end
