class Plan < ApplicationRecord
  belongs_to :folder, optional: true
  belongs_to :user
  validates :title, presence: true,  length: { maximum: 10 }
  validates :place, presence: true,  length: { maximum: 10 }
  validates :start, presence: true
  validates :memo, length: { maximum: 300 }
  validate :start_end_check, if: :published?
  def published? 
    self.end != nil
  end

  def start_end_check
    errors.add(:end, "は開始時間より前の日付は登録できません。") unless
    self.start < self.end
  end
end
