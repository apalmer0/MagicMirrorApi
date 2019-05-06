class RemoveFieldsFromTriviaItems < ActiveRecord::Migration[5.1]
  def change
    remove_column :trivia_items, :value, :integer
    remove_column :trivia_items, :response, :string
  end
end
