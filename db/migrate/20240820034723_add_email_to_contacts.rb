class AddEmailToContacts < ActiveRecord::Migration[7.1]
  def change
    add_column :contacts, :email, :string
  end
end
