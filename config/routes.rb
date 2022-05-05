Rails.application.routes.draw do
  root to: 'static_pages#homepage'
    get 'static_pages/contact'
    get 'static_pages/about'
end
