class ChangeIdsInUpvotes < ActiveRecord::Migration[5.0]
  def change
    remove_column :upvotes, :sentence_id, :integer
    add_column :upvotes, :upvotable_id, :integer
    add_column :upvotes, :upvotable_type, :string
  end
end
