class AddDeletedAtToNote < ActiveRecord::Migration[6.1]
  def change
    add_column :notes, :deletes_at, :datetime
    add_index :notes, deleted_at
  end
end
