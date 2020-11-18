class PagesController < ApplicationController
  def index
    @pages = Page.all
  end

  def about
    @page = Page.where("page_type = ?", "about").limit(1)
  end

  def contact
    @page = Page.where("page_type = ?", "contact").limit(1)
  end
end
