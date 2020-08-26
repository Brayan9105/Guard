class AddSymptomsToVisits < ActiveRecord::Migration[6.0]
  def change
    add_column :visits, :symptoms, :string
  end
end
