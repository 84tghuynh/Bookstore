class BooksController < ApplicationController
  def index
    # @pagy, @books = pagy(Book.all, items: 20)

    @not_search = true

    @path_route = root_path
    @sales_check = false
    @update_check = false

    @sales_check = true if params[:on_sale].present?

    @update_check = true if params[:last_update].present?

    # @pagy, @books = pagy(Category.find(params[:id]).books, items: 20)
    # true, false
    if @sales_check && !@update_check
      @pagy, @books = pagy(Book.all.where("sales > 0.0099"), items: 21)
    # true, true
    elsif @sales_check && @update_check
      @pagy, @books = pagy(Book.all.where("sales > 0.0099")
                                  .where("updated_at >= ?", (Date.today - 3).to_datetime), items: 21)
    # false, true
    elsif !@sales_check && @update_check
      @pagy, @books = pagy(Book.all.where("updated_at >= ?", (Date.today - 3).to_datetime), items: 21)
    # false, false
    else
      @pagy, @books = pagy(Book.all, items: 21)
    end

    @categories = Category.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def search
    @not_search = false
    wildcard_search = "%#{params[:keywords]}%"

    @category = (Category.find(params[:category]) if params[:category].to_s != "0")

    category_search = params[:category].to_s

    @pagy1, @books = pagy(if category_search == "0"
                            Book.where(["title LIKE ? OR books.description LIKE ?", wildcard_search, wildcard_search])
                          else
                            Book.joins(:category)
                                .where(["title LIKE ? OR books.description LIKE ?", wildcard_search, wildcard_search])
                                .where("category_id = ?", category_search)
                          end, items: 21)

    @categories = Category.all
  end
end
