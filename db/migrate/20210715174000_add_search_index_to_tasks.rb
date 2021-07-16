class AddSearchIndexToTasks < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_index :tasks, :title, algorithm: :concurrently
    add_index :tasks, :status, algorithm: :concurrently

    add_index :tags, :task_id, algorithm: :concurrently
  end
end
