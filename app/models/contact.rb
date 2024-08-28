require 'open-uri'

class Contact < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:first_name, :last_name, :email, :phone]

  belongs_to :company, optional: true
  belongs_to :user
  has_many :todos, as: :todoable
  has_many :notes, as: :noteable
  has_many :event_contacts
  has_many :events, through: :event_contacts
  has_one_attached :avatar
  has_one_attached :business_card

  def extract_info_from_business_card
    return unless business_card.attached?

    card_info = ExtractBusinessCard.new(business_card.url).call
    update(card_info)
  end
end
