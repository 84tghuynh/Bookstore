Rails.application.routes.draw do
  get 'books/index'
  get 'books/show'
  root to: "pages#index"
  get "pages/about", to: "pages#about", as: "about"
  get "pages/contact", to: "pages#contact", as: "contact"
  get "abouts/index"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
