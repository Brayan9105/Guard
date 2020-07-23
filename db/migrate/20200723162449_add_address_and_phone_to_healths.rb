class AddAddressAndPhoneToHealths < ActiveRecord::Migration[6.0]
  def change
    add_column :healths, :address, :string
    add_column :healths, :phone, :string
  end
end
