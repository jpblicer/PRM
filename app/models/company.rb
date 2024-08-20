class Company < ApplicationRecord
  belongs_to :user
  has_many :contacts
  has_many :events
  has_many :todos, as: :todoable
  has_many :notes, as: :noteable
end
