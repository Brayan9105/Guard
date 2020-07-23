class ChangeInTemperatureToBeDecimalInVisits < ActiveRecord::Migration[6.0]
  def change
    change_column :visits, :in_temperature, :decimal
    change_column :visits, :out_temperature, :decimal
  end
end
