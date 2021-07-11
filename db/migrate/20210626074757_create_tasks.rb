class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.due_date :date
      t.string :priority
      t.string :status
      t.string :tag
      t.text :content

      t.timestamps
    end
  end
end
