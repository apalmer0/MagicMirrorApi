class RenameTriviaItemsAnswer < ActiveRecord::Migration[5.1]
  def change
    rename_column :trivia_items, :answer, :correct_answer
  end
end
