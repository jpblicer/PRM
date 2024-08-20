class CreateComapnies < ActiveRecord::Migration[7.1]
  def change
    create_table :comapnies do |t|
      t.string :name
      t.text :address
      t.string :phone
      t.string :website
      t.boolean :archive
      t.string :linkedin
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
