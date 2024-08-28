class Company < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:name, :phone]
  belongs_to :user
  has_many :contacts
  has_many :events
  has_many :todos, as: :todoable
  has_many :notes, as: :noteable
  has_one_attached :avatar
end
