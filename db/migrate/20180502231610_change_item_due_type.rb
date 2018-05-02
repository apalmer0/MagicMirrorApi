class ChangeItemDueType < ActiveRecord::Migration[5.1]
  def up
    change_column :items, :due, :date
  end

  def down
    change_column :items, :due, :datetime
  end
end
