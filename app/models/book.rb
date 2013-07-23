class Book < ActiveRecord::Base
  attr_accessible :author, :description, :genre, :isbn, :title, :photo, :goodreadsphoto
  mount_uploader :photo, PhotoUploader

  has_many :books_users
  has_many :users, :through => :books_users

  before_create :extract_goodreads_info, 
    :if => :isbn?

    def extract_goodreads_info
      @client = Goodreads.new
      @book = @client.book_by_isbn(self.isbn)
      self.title = @book.title
      self.author = @book.authors.author.first.name
      self.description = Sanitize.clean(@book.description)
      self.goodreadsphoto = @book.image_url
    end
end