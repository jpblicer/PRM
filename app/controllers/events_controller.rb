class EventsController < ApplicationController

  def index
    @events = Event.where('end_date >= ?', Date.today).order(start_date: :asc)
    @events = case params[:filter]
              when 'upcoming'
                Event.where('end_date >= ?', Date.today).order(start_date: :asc)
              when 'past'
                Event.where('end_date <= ?', Date.today).order(start_date: :asc)
              else
                Event.all
              end
    @page_title = 'Events'
  end

  def new
    @event = Event.new
    @contact_collection = Contact.all
    @contact_names_collection = Contact.all.map { |contact| ["#{contact.first_name} #{contact.last_name}", contact.id] }
    @page_title = 'New Event'

    if params[:event_image]
      event_info = ExtractEventInfo.new(params[:event_image])
      extracted_data = event_info.call
      @event.assign_attributes(extracted_data)
    end
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user

    if @event.save
      if @event.event_image.attached?
        # Attempt to extract data from the event image
        if @event.extract_info_from_event_image
          redirect_to edit_event_path(@event)
        else
          # If extraction fails, delete the event and show an error
          @event.destroy
          flash.now[:alert] = 'Failed to extract data from the business card. Please try again.'
          render turbo_stream: turbo_stream.replace(:new_event, partial: "events/new", locals: { event: @event }), status: :unprocessable_entity
        end
      else
        redirect_to events_path, notice: 'Event was successfully created.'
      end
    else
      flash.now[:alert] = 'There was an issue creating the event. Please review the form and try again.'
      render turbo_stream: turbo_stream.replace(:new_event, partial: "events/new", locals: { event: @event }), status: :unprocessable_entity
    end

    # if @event.save
    #   redirect_to events_path

    # else
    #   render turbo_stream: turbo_stream.replace(:new_event, partial: "events/new",
    #     locals: { event: @event })
    # end

    # if @event.save
    #   if @event.event_image.attached?
    #     # Attempt to extract data from the business card
    #     if @event.extract_info_from_event_image
    #       redirect_to edit_event_path(@event)
    #     else
    #       # If extraction fails, delete the event and show an error
    #       @event.destroy
    #       flash.now[:alert] = 'Failed to extract data from the business card. Please try again.'
    #       render 'new', status: :unprocessable_entity
    #     end
    #   else
    #     redirect_to events_path, notice: 'Event was successfully created.'
    #   end
    # else
    #   flash.now[:alert] = 'There was an issue creating the event. Please review the form and try again.'
    #   render 'new', status: :unprocessable_entity
    # end

  end

  def edit
    @event = Event.find(params[:id])
    @contact_names_collection = Contact.all.map { |contact| ["#{contact.first_name} #{contact.last_name}", contact.id] }
    @page_title = 'Confirm Event'
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to events_path, notice: 'Event was successfully updated.'
    else
      flash.now[:alert] = 'There was an issue updating the event. Please review the form and try again.'
      render 'edit', status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :address, :company_id, :start_date, :end_date, :user_id, :event_image, contact_ids: [])
  end
end
