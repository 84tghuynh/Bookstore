Rails.application.routes.draw do
  devise_for :customers
  # get 'categories/index'
  # get 'categories/show'
  resources :categories, only: %i[index show] do
    collection do
      get "filter"
    end
  end

  # get 'books/index'
  # get 'books/show'
  # using
  resources :books, only: %i[index show] do
    collection do
      get "search"
      get "filter"
    end
  end
  # OR
  # get "books",     to: "books#index", as: "books" # books_path
  # get "books/:id", to: "books#show",  as: "book"

  get "pages/about", to: "pages#about", as: "about"
  get "pages/contact", to: "pages#contact", as: "contact"

  root to: "books#index"

  # Active Admin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
