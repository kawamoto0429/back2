class Folder < ApplicationRecord
  belongs_to :format
  belongs_to :user
  has_many :todoes, dependent: :destroy
  has_many :plans, dependent: :destroy
  validates :format, presence: true
  validates :name, presence: true, length: { maximum: 10 }
end
