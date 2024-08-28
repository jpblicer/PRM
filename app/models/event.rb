class Event < ApplicationRecord
  belongs_to :company, optional: true
  belongs_to :user
  has_many :todos, as: :todoable
  has_many :event_contacts, dependent: :destroy
  has_many :contacts, through: :event_contacts
  has_one_attached :event_image

  def extract_info_from_event_image
    return unless event_image.attached?

    event_info = ExtractEventInfo.new(event_image.url).call
    update(event_info)
  end
end
