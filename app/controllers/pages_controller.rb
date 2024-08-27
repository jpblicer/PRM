class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @recent_contacts = Contact.order(updated_at: :desc).first(3)
    todos = Todo.all
    events = Event.all
    combined_records = todos.to_a + events.to_a
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
end
