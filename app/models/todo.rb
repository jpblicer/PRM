class Todo < ApplicationRecord
  belongs_to :todoable, polymorphic: true, optional: true
  belongs_to :user
  enum status: { not_started: 0, in_progress: 1, done: 2 }

  validates :name, presence: true
  validates :end_date, presence: true
  validates_comparison_of :end_date, greater_than: Date.today
end
