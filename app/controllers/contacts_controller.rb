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
    if @contact.save
      @contact.extract_info_from_business_card if @contact.business_card.attached?
      redirect_to contact_path(@contact), notice: 'Contact was successfully created.'
    else
      flash.now[:alert] = 'There was an issue creating the contact. Please review the form and try again.'
      render 'new', status: :unprocessable_entity
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
