class ChangeTodoStatusColumnDefault < ActiveRecord::Migration[7.1]
  def change
    change_column_default(:todos, :status, from: nil, to: 0)
  end
end
