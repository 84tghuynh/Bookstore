class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    # @category = Category.find(params[:id])
    @sales_check = false
    @update_check = false

    @sales_check = true if params[:on_sale].present?

    @update_check = true if params[:last_update].present?

    # @pagy, @books = pagy(Category.find(params[:id]).books, items: 20)
    # true, false
    if @sales_check && !@update_check
      @pagy, @books = pagy(Category.find(params[:id]).books.where("sales > 0.0"), items: 20)
    # true, true
    elsif @sales_check && @update_check
      @pagy, @books = pagy(Category.find(params[:id]).books.where("sales > 0.0")
                                                          .where("updated_at >= ?", (Date.today - 3).to_datetime), items: 20)
    # false, true
    elsif !@sales_check && @update_check
      @pagy, @books = pagy(Category.find(params[:id]).books.where("updated_at >= ?", (Date.today - 3).to_datetime), items: 20)
    # false, false
    else
      @pagy, @books = pagy(Category.find(params[:id]).books, items: 20)
    end

    @categories = Category.all
  end
end
