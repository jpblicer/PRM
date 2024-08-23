class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @recent_contacts = Contact.order(updated_at: :desc).first(3)
    todos = Todo.all
    events = Event.all
    combined_records = todos.to_a + events.to_a
    @sorted_records = combined_records.sort_by { |record| record.end_date || Time.at(0) }
    @page_title = 'Dashboard'
  end
end
