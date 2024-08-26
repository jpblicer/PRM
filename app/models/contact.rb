class Contact < ApplicationRecord
  belongs_to :company, optional: true
  belongs_to :user
  has_many :todos, as: :todoable
  has_many :notes, as: :noteable
  has_many :event_contacts
  has_many :events, through: :event_contacts
  has_one_attached :avatar
end
