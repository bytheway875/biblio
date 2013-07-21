class Book < ActiveRecord::Base
  attr_accessible :author, :description, :genre, :isbn, :title, :photo
  mount_uploader :photo, PhotoUploader

    @@client = Goodreads.new

  def find_book_by_isbn(isbn)
  	@@client.book_by_isbn(isbn)
  end

  def get_isbn(isbn)
  	@book = self.find_book_by_isbn(isbn)
  	@book.isbn
  end

  def get_title(isbn)
  	@book = self.find_book_by_isbn(isbn)
  	@book.title
  end

  def get_author(isbn)
  	@book = self.find_book_by_isbn(isbn)
  	@book.authors.author.name
  end

  def get_description(isbn)
  	@book = self.find_book_by_isbn(isbn)
  	@book.description
  end

  def get_photo(isbn)
  	@book = self.find_book_by_isbn(isbn)
  	@book.image_url
  end

  has_and_belongs_to_many :users
end
