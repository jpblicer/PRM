class EventContact < ApplicationRecord
  belongs_to :event
  belongs_to :contact
end
