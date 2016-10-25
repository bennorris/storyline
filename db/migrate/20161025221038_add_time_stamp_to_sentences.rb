class AddTimeStampToSentences < ActiveRecord::Migration[5.0]
  def change
    add_column :sentences, :created_at, :datetime
    add_column :sentences,  :updated_at, :datetime
  end
end
