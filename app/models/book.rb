class Book < ActiveRecord::Base
  attr_accessible :author, :description, :genre, :isbn, :title, :photo, :goodreadsphoto
  mount_uploader :photo, PhotoUploader

  has_many :reviews
  has_many :users, :through => :reviews

  before_create :extract_goodreads_info, 
    :if => :isbn?

    def extract_goodreads_info
      @client = Goodreads.new
      # need to have error handling when isbn is not in Goodreads db
      # begin rescue
      @book = @client.book_by_isbn(self.isbn)
      if @book
        self.title = @book.title
      end
      if @book.authors.author.is_a?(Array)
        self.author = @book.authors.author.first.name
      else
        self.author = @book.authors.author.name
      end
      self.description = Sanitize.clean(@book.description)
      self.goodreadsphoto = @book.image_url
    end
end