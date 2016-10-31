class AddGenreIdToStories < ActiveRecord::Migration[5.0]
  def change
    add_column :stories, :genre_id, :integer 
  end
end
