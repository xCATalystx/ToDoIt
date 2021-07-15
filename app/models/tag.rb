class Tag < ApplicationRecord
  validates :name, presence: true, length: {minimum: 2, maximum: 15}
  validates :name, uniqueness: true

  has_many :taggings
  has_many :tasks, through: :taggings
end
