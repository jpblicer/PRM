class CreateEventContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :event_contacts do |t|
      t.references :event, null: false, foreign_key: true
      t.references :contact, null: false, foreign_key: true

      t.timestamps
    end
  end
end
