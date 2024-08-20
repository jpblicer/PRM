class Note < ApplicationRecord
  belongs_to :noteable, polymorphic: true, optional: true
  belongs_to :user
end
