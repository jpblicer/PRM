class CompaniesController < ApplicationController
  def index
    @companies = Company.all
    @page_title = "Companies"
  end

  def show
    @company = Company.find(params[:id])
    @page_title = "Company"
    @todo = Todo.new
    @note = Note.new
  end

  def new
    @company = Company.new
    @page_title = 'New Company'
  end

  def create
    # debugger
    @company = params[:name] ? Company.create!(name: params[:name], user: current_user) : Company.new(company_params)
    @company.user = current_user

    if params[:name].nil?
      if @company.save
        redirect_to @company
      else
        render :new, status: :unprocessable_entity
      end
    else
      @contact = Contact.new
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :phone, :address, :email, :avatar)
  end
end
