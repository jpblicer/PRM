class Todo < ApplicationRecord
  belongs_to :contact
  belongs_to :company
  belongs_to :event
  belongs_to :user
end
