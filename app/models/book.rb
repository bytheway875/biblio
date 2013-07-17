class Book < ActiveRecord::Base
  attr_accessible :author, :description, :genre, :isbn, :title, :photo
  mount_uploader :photo, PhotoUploader

  def find_book_by_isbn
  end

  has_and_belongs_to_many :users
end
