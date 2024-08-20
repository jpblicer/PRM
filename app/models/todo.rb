class Todo < ApplicationRecord
  belongs_to :todoable, polymorphic: true, optional: true
  belongs_to :user
  enum status: { not_started: 0, in_progress: 1, done: 2 }, default: 0
end
