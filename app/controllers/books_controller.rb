class BooksController < ApplicationController
  def index
    @pagy, @books = pagy(Book.all, items: 20)

    @categories = Category.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def search
    wildcard_search = "%#{params[:keywords]}%"
    category_search = params[:category].to_s

    @pagy1, @books = pagy(if category_search == "0"
                            Book.where(["title LIKE ? OR books.description LIKE ?", wildcard_search, wildcard_search])
                          else
                            Book.joins(:category)
                                .where(["title LIKE ? OR books.description LIKE ?", wildcard_search, wildcard_search])
                                .where("category_id = ?", category_search)
                          end, items: 20)

    @categories = Category.all
  end
end
