class Event < ApplicationRecord
  belongs_to :company, optional: true
  belongs_to :user
  has_many :todos, as: :todoable
  has_many :event_contacts
  has_many :contacts, through: :event_contacts
end
