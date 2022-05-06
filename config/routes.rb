Rails.application.routes.draw do
  devise_for :users
  root to: 'static_pages#homepage'
    get 'static_pages/contact'
    get 'static_pages/about'
end
