class AddGoodreadsphotoToBooks < ActiveRecord::Migration
  def change
    add_column :books, :goodreadsphoto, :string
  end
end
