class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ , message: "must be a valid email address!" }

  before_destroy :check_user_count, prepend: true

  def check_user_count
    if User.all.count == 1
      throw(:abort)
    end
  end
end
