class SaveCorrectMultipleChoiceLetter < ActiveRecord::Migration[5.1]
  def change
    add_column :trivia_items, :correct_letter, :string
  end
end
