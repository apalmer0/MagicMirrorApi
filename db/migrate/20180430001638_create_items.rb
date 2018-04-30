class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :content, null: false
      t.string :todoist_id, null: false
      t.datetime :due
      t.integer :status

      t.timestamps
    end
  end
end
