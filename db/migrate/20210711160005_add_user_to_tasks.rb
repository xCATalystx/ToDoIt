class AddUserToTasks < ActiveRecord::Migration[6.1]
  def change
    def change
      add_reference :tasks, :user
    end
  end
end
