class TodosController < ApplicationController
  def new
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
        # format.html { redirect_to batch_path(@batch) }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(:todos, partial: "todos/todos",
            locals: { contact: @todo.todoable })
        end
      end
    else
      render turbo_stream: turbo_stream.replace(:new_todo, partial: "todos/todo_form",
        locals: { todo: @todo })
    end
  end

  private

  def todo_params
    params.require(:todo).permit(:name, :end_date, :status, :todoable_id, :todoable_type)
  end
end
