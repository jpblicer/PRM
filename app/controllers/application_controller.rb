class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :perform_search


  def perform_search
    if params[:query].present?
      @results = PgSearch.multisearch(params[:query])
    else
      @results = []
    end
  end
end

