class CreateSentences < ActiveRecord::Migration[5.0]
  def change
    create_table :sentences do |t|
      t.integer :user_id
      t.integer :story_id
      t.string :content 
    end
  end
end
