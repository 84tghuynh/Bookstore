class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    # @category = Category.find(params[:id])

    @pagy, @books = pagy(Category.find(params[:id]).books, items: 20)
    @categories = Category.all
  end
end
