class AddStatusToImage < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :status, :integer
  end
end
