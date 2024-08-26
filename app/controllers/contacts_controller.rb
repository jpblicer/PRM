class ContactsController < ApplicationController
  def index
    @contacts = Contact.all
    @page_title = 'Contacts'
  end

  def show
    @contact = Contact.find(params[:id])
    @todo = Todo.new
    @note = Note.new
    @page_title = 'Contact Details'
    @event = Event.new
    @events = Event.where(id: @contact.events.pluck(:id))
  end

  def new
    @contact = Contact.new
    @page_title = 'New Contact'
    if params[:business_card]
      card_info = ExtractBusinessCard.new(params[:business_card])
      extracted_data = card_info.call
      @contact.assign_attributes(extracted_data)
    end
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.user = current_user

    # Attempt to save the contact first
    if @contact.save
      # If the contact has a business card attached, process it and redirect to the edit page
      if @contact.business_card.attached?
        @contact.extract_info_from_business_card
        redirect_to edit_contact_path(@contact), alert: 'Optional: Input missing fields manually'
      else
        redirect_to contact_path(@contact), notice: 'Contact was successfully created.'
      end
    else
      # Handle validation errors or other issues with saving
      flash.now[:alert] = 'There was an issue creating the contact. Please review the form and try again.'
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @contact = Contact.find(params[:id])
    # @page_title = 'Edit Contact'
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      redirect_to contact_path(@contact), notice: 'Contact was successfully created.'
    else
      flash.now[:alert] = 'There was an issue updating the contact. Please review the form and try again.'
      render 'edit', status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.require(:contact).permit(
      :first_name, :last_name, :job_title, :phone, :address,
      :birthday, :linkedin, :email, :country, :company_id,
      :avatar, :business_card
    )
  end
end
