class AddAboutColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :about, :string
  end
end
