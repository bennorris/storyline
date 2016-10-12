class CreateStoryUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :story_users do |t|
      t.integer :user_id
      t.integer :story_id 
      t.timestamps
    end
  end
end
