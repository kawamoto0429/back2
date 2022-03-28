class Todo < ApplicationRecord
  belongs_to :folder, optional: true
  belongs_to :user
  validates :content, presence: true,  length: { maximum: 10 }
  validates :memo, length: { maximum: 300 }
end
