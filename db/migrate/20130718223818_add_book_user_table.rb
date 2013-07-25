class AddBookUserTable < ActiveRecord::Migration
  def change
  	create_table :books_users do |t|
  		t.integer :user_id
  		t.integer :book_id
  	end
  end

end

# never take the primary id out again!