class AddUserIdToGenres < ActiveRecord::Migration[5.0]
  def change
    add_column :genres, :user_id, :integer 
  end
end
