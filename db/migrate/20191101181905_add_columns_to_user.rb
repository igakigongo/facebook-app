class AddColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :date_of_birth, :date, null: false
    add_column :users, :first_name, :string,  null: false
    add_column :users, :gender, :string,      null: false
    add_column :users, :image_url, :string,   null: false
    add_column :users, :surname, :string,     null: false
  end
end
