class AddObservationsToVisit < ActiveRecord::Migration[6.0]
  def self.up
    add_column :visits, :observation, :text
  end
end
