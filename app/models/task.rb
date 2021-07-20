class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  has_many :taggings
  has_many :tags, through: :taggings

  has_many :notes
  belongs_to :user

  def self.search(keyword)
    Task.left_outer_joins(:tags).where("title like '%#{keyword}%' or 
                                        status like '#{keyword}'
    ")
  end
  
  def self.tagged_with(name)
    Tag.find_by!(name: name).tasks
  end

  def all_tags
    tags.map{|t| t.name}.join(',')
  end

  def all_tags=(names)
    self.tags = names.split(',').map do |name|
                Tag.where(name: name.strip).first_or_create
    end
  end
end
