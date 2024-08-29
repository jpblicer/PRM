class TodosController < ApplicationController
  def index
    @filter = params[:filter] || 'pending'
    @todos = case params[:filter]
             when 'pending'
               Todo.pending.order(end_date: :asc)
             when 'overdue'
               Todo.overdue.order(end_date: :asc)
             when 'completed'
               Todo.completed.order(end_date: :asc)
             when 'all_todos'
               Todo.all_todos.order(end_date: :asc)
             else
               Todo.all_todos.order(end_date: :asc)
             end
    @page_title = "To Dos"
  end

  def new
    @page_title = 'New To Do'
    @todo = Todo.new
  end

  def show
    @todo = Todo.find(params[:id])
  end

  def create
    @todo = Todo.new(todo_params)
    @todo.user = current_user

    if @todo.save
      # redirect_to @todo
      respond_to do |format|
        if @todo.company.present? || @todo.contact.present?
          format.turbo_stream do
            render turbo_stream: turbo_stream.replace(
              :todos,
              partial: "todos/todo",
              locals: { todo: @todo }
            )
          end
        else
          format.html { redirect_to todos_path }
        #   redirect_to todos_path
        end
      end
    else
      render turbo_stream: turbo_stream.replace(:new_todo, partial: "todos/todo_form",
        locals: { todo: @todo })
    end
  end

  def update
    @todo = Todo.find(params[:id])
    @todo.update(todo_params)
    respond_to do |format|
      # format.html
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          :todos,
          partial: "todos/todo",
          locals: { todo: @todo }
        )
      end
    end
  end

  private

  def todo_params
    params.require(:todo).permit(:name, :end_date, :status, :todoable_id, :todoable_type)
  end
end
