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
      redirect_to root
      raise
    else
      render :new, status: :unprocessable_entity
      raise
    end
  end

  private

  def todo_params
    params.require(:todo).permit(:name, :end_date, :status)
  end
end
