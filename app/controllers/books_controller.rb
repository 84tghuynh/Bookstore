class BooksController < ApplicationController
  def index
    @pagy, @books = pagy(Book.all, items: 20)
  end

  def show
    @book = Book.find(params[:id])
  end
end
