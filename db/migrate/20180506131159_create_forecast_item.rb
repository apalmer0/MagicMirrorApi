class CreateForecastItem < ActiveRecord::Migration[5.1]
  def change
    create_table :forecast_items do |t|
      t.string :unix_time
      t.integer :precip_chance
      t.integer :temperature

      t.timestamps
    end
  end
end
