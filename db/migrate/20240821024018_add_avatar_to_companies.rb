class AddAvatarToCompanies < ActiveRecord::Migration[7.1]
  def change
    add_column :companies, :avatar, :string
  end
end
