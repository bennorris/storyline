class AddUidColumnToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :uid, :integer, limit: 8
    add_index :users, :uid, unique: true
  end
end
