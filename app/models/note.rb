class Note < ApplicationRecord
  belongs_to :company
  belongs_to :contact
  belongs_to :user
end
