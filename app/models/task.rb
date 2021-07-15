class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  has_many :taggings
  has_many :tags, through: :taggings, dependent: :destroy

  has_many :notes, dependent: :destroy
  belongs_to :user

  def self.search(keyword)
    Task.left_outer_joins(:tags).where("title like '%#{keyword}%' or 
                                        tags.name like '%#{keyword}%' or 
                                        status like '%#{keyword}%'
    ")
  end

  def all_tags
    tags.map{|t| t.name}.join(',')
  end

  def all_tags=(names)
    self.tags = names.split(',').map do |name|
                Tag.where(name: name.strip).first_or_create
    end
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
