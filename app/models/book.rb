class Book < ActiveRecord::Base
  attr_accessible :author, :description, :genre, :isbn, :title, :photo, :goodreadsphoto
  mount_uploader :photo, PhotoUploader

  has_many :reviews
  has_many :users, :through => :reviews

  before_create :extract_goodreads_info, 
    :if => :isbn?

    def extract_goodreads_info
      @client = Goodreads.new
      @book = @client.book_by_isbn(self.isbn)
      self.title = @book.title
      if @book.authors.author.is_a?(Array)
        self.author = @book.authors.author.first.name
      else
        self.author = @book.authors.author.name
      end
      self.description = Sanitize.clean(@book.description)
      self.goodreadsphoto = @book.image_url
    end
end