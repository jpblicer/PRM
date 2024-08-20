class CreateTodos < ActiveRecord::Migration[7.1]
  def change
    create_table :todos do |t|
      t.string :name
      t.date :end_date
      t.integer :status
      t.integer :todoable_id
      t.string :todoable_type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
