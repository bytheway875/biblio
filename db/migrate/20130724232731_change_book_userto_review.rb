class ChangeBookUsertoReview < ActiveRecord::Migration
  def change
    rename_table :books_users, :reviews
  end
end
