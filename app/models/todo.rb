class Todo < ApplicationRecord
  belongs_to :todoable, polymorphic: true, optional: true
  belongs_to :user
end
