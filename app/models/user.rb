class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :email, :username, :password, :password_confirmation, :remember_me, :user_id
  
  has_many :books_users
  has_many :books, :through => :books_users 
end


# check to see if book exists
# if it does, create the books_users record that ties it together
# if it doesnt, create the book and tie the books_use record together