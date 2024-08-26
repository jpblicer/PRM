class CompaniesController < ApplicationController
  def index
    @companies = Company.all
    @page_title = "Companies"
  end

  def show
    @company = Company.find(params[:id])
    @page_title = 'Company Details'
  end

  def new
    @company = Company.new
    @page_title = 'New Company'
  end

  def create
    @company = Company.new(company_params)
    @company.user = current_user

    if @company.save
      redirect_to @company
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def company_params
    params.require(:company).permit(:title, :body)
  end
end
