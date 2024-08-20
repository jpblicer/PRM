class CreateNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :notes do |t|
      t.text :content
      t.integer :noteable_id
      t.string :noteable_type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
