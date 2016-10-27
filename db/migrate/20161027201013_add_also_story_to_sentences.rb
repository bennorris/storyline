class AddAlsoStoryToSentences < ActiveRecord::Migration[5.0]
  def change
    add_column :sentences, :also_story, :boolean, :default => false 
  end
end
