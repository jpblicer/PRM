class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]
  before_action :set_default_filter


  def home
    @recent_contacts = Contact.order(updated_at: :desc).first(3)
    @todos = Todo.where(end_date: [Date.today, Date.tomorrow])
    @events = Event.where(end_date: [Date.today, Date.tomorrow])
    combined_records = @todos.to_a + @events.to_a
    @sorted_records = combined_records.sort_by { |record| record.end_date || Time.at(0) }

    @sorted_records = case params[:filter]
                      when 'events'
                        @sorted_records.select { |record| record.is_a?(Event) }
                      when 'todos'
                        @sorted_records.select { |record| record.is_a?(Todo) }
                      else
                        @sorted_records
                      end
    @page_title = 'Dashboard'
  end

  def search
    # `perform_search` is called automatically due to the before_action in ApplicationController
    respond_to do |format|
      format.html # Renders the default search page
      format.json { render 'pages/search', formats: :json }
    end
  end

  def set_default_filter
    params[:filter] ||= "todos"
  end

end
