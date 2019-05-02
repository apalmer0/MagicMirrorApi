class CreateTriviaItems < ActiveRecord::Migration[5.1]
  def change
    create_table :trivia_items do |t|
      t.string :question, null: false
      t.string :answer, null: false
      t.string :response
      t.integer :status
      t.string :category, null: false
      t.integer :value, null: false


      t.timestamps
    end
  end
end
