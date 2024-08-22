class EventsController < ApplicationController
  def new
    @event = Event.new
    @contact_collection = Contact.all
    @contact_names_collection = Contact.all.map { |contact| ["#{contact.first_name} #{contact.last_name}", contact.id] }
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      redirect_to event_path(@event)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :address, :company_id, :start_date, :end_date, :user_id, contact_ids: [])
  end
end
