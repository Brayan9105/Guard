class ChangePrecisionToTemperatureInVisit < ActiveRecord::Migration[6.0]
  def self.up
    change_column :visits, :in_temperature, :decimal, precision: 3, scale: 1
    change_column :visits, :out_temperature, :decimal, precision: 3, scale: 1
  end
end
