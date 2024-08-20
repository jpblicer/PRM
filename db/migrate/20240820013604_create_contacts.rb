class CreateContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :job_title
      t.string :phone
      t.text :address
      t.date :birthday
      t.boolean :archive
      t.string :linkedin
      t.references :company, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
