class ChangeStoriesColumns < ActiveRecord::Migration[5.0]
  def change
    add_column :stories, :full_story, :string
    remove_column :stories, :content, :string
    add_column :stories, :beginning, :string
  end
end
