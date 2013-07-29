class BooksController < ApplicationController
  before_filter :authenticate_user!, except: [:index]
  # GET /books
  # GET /books.json
  def index
    @books = Book.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @books }
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @book = Book.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/new
  # GET /books/new.json
  def new
    @book = Book.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
  end

  # POST /books
  # POST /books.json
  def create

    @book = Book.find_or_create_by_isbn(params[:book][:isbn]) do |book|
      book.title = params[:book][:title]
      book.description = params[:book][:description]
      book.author = params[:book][:author]
      book.genre = params[:book][:genre]
      book.photo = params[:book][:goodreadsphoto]
    end

    @review = current_user.reviews.find_or_create_by_book_id(@book.id)

    respond_to do |format|
      if @book.persisted?
        format.html { redirect_to @book, notice: "That book is already in Biblio's database, so we'll add it to your reading list." }
        format.json { render json: @book, status: :created, location: @book }
      elsif @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render json: @book, status: :created, location: @book }
      else
        format.html { render action: "new" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.json
  def update
    @book = Book.find(params[:id])

    respond_to do |format|
      if @book.update_attributes(params[:book])
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    current_user.reviews.where(book_id: params[:id]).destroy_all

    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end
end
