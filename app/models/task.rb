class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  has_many :notes
  belongs_to :user

  def self.search(keyword)
    where("title like '%#{keyword}%' or tag like '%#{keyword}%' or status like '%#{keyword}%'")
  end

  def self.priority_order
    order(
      Arel.sql("
        case
          when priority = '高' then '3'
          when priority = '中' then '2'
          when priority = '低' then '1'
        end
      SQL")
    )
  end

end
