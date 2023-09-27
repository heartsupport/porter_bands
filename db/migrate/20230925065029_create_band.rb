class CreateBand < ActiveRecord::Migration[7.0]
  def change
    create_table :bands do |t|
      t.integer :group_id, null: false
      t.string :path, null: false
      t.string :name, null: false
      t.timestamps
    end
  end
end
