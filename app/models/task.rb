class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  has_many :notes
  belongs_to :user
end
