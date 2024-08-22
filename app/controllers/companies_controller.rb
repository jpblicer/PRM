class CompaniesController < ApplicationController
  def show
    @company = Company.find(params[:id])
    @page_title = 'Company Details'
  end
end
