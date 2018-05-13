class AddFieldsToImage < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :query, :string
    add_column :images, :image_source, :integer
  end
end
