class CreateImage < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string :url
      t.string :from_number
      t.string :caption

      t.timestamps
    end
  end
end
