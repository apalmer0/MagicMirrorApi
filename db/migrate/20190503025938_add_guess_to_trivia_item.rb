class AddGuessToTriviaItem < ActiveRecord::Migration[5.1]
  def change
    add_column :trivia_items, :guess, :string
  end
end
