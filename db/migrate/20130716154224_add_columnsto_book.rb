class AddColumnstoBook < ActiveRecord::Migration
  def change
    add_column :books, :photo, :string
    change_column :books, :isbn, :string
  end
end
