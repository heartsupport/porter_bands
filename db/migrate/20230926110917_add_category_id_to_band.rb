class AddCategoryIdToBand < ActiveRecord::Migration[7.0]
  def change
    add_column :bands, :category_id, :integer
  end
end
