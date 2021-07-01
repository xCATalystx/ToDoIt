class Note < ApplicationRecord
  belongs_to :task
  validates :content, presence: true

  default_scope { where(deleted_at: nil) }

  def destroy
    update(deleted_at: Time.now)
  end
end
