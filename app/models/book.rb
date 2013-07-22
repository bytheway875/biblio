class Book < ActiveRecord::Base
  attr_accessible :author, :description, :genre, :isbn, :title, :photo, :goodreadsphoto
  mount_uploader :photo, PhotoUploader

  has_and_belongs_to_many :users

  if not :isbn.blank?
    before_create do
      @client = Goodreads.new
      @book = @client.book_by_isbn(self.isbn)
      self.title = @book.title
      self.author = @book.authors.author.name
      self.description = Sanitize.clean(@book.description)
      self.goodreadsphoto = @book.image_url
    end
  end

end