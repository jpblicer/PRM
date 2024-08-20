class AddCountryToContacts < ActiveRecord::Migration[7.1]
  def change
    add_column :contacts, :country, :string
  end
end
