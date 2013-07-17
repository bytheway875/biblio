class AddUsertoBooks < ActiveRecord::Migration
  def change
  	change_table(:books) do |t|
	  	t.integer :user_id
  	end
  end

end
