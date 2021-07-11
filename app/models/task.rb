class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  has_many :notes
  belongs_to :user

  def self.search(keyword)
    where("title like '%#{keyword}%' or tag like '%#{keyword}%' or status like '%#{keyword}%'")
  end
end
