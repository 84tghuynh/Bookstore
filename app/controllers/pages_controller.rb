class PagesController < ApplicationController
  def index
    @pages = Page.all
  end

  def about; end

  def contact; end
end
