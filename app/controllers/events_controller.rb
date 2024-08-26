class EventsController < ApplicationController
  def new
    @event = Event.new
    @contact_collection = Contact.all
    @contact_names_collection = Contact.all.map { |contact| ["#{contact.first_name} #{contact.last_name}", contact.id] }
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    # @contact = Contact.find(params[:contact_id])

    if @event.save
      redirect_to events_path
      # event_params[:contact_ids].each do |contact_id|
      #   next if contact_id.blank?
      #   EventContact.create(event: @event, contact_id: contact_id)
      # end

      # respond_to do |format|
      #   format.turbo_stream do
      #     render turbo_stream: turbo_stream.replace(:events, partial: "events/events",
      #       locals: { events: @contact.events })
      #   end
      # end
    else
      render turbo_stream: turbo_stream.replace(:new_event, partial: "events/new",
        locals: { event: @event })
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :address, :company_id, :start_date, :end_date, :user_id, contact_ids: [])
  end
end
