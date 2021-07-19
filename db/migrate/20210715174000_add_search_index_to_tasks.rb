class AddSearchIndexToTasks < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_index :tasks, :title, algorithm: :concurrently
    add_index :tasks, :status, algorithm: :concurrently
  end
end
