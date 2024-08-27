class EventContactsController < ApplicationController
  def create
    @event_contact = EventContact.new(event_contact_params)
    if @event_contact.save
      redirect_to contact_path(@event_contact.contact), notice: 'Contact was successfully added to the event.'
    else
      flash[:alert] = 'There was an issue adding the contact to the event.'
      redirect_to contact_path(@event_contact.contact)
    end
  end

  private

  def event_contact_params
    params.require(:event_contact).permit(:event_id, :contact_id)
  end
end
