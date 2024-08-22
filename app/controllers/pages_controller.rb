class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    todos = Todo.all
    events = Event.all
    combined_records = todos.to_a + events.to_a
    @sorted_records = combined_records.sort_by { |record| record.end_date || Time.at(0) }.reverse
    @page_title = 'Dashboard'
  end
end
