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
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.user = current_user
    if @contact.save
      redirect_to contact_path(@contact)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :job_title, :phone, :address, :birthday, :linkedin, :email, :country, :company_id, :avatar)
  end
end
