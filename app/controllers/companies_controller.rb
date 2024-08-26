class CompaniesController < ApplicationController
  def index
    @companies = Company.all
    @page_title = "Companies"
  end

  def show
    @company = Company.find(params[:id])
    @page_title = 'Company Details'
  end
end
