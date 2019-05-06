class AddFieldsToTriviaItems < ActiveRecord::Migration[5.1]
  def change
    add_column :trivia_items, :incorrect_answers, :string, array: true
    add_column :trivia_items, :difficulty, :string, null: false
    add_column :trivia_items, :question_type, :string, null: false
  end
end
