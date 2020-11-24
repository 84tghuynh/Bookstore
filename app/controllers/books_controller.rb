class BooksController < ApplicationController
  def index
    @pagy, @books = pagy(Book.all, items: 10)
  end

  def show
    @book = Book.find(params[:id])
  end
end
