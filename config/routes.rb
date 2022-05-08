Rails.application.routes.draw do
  devise_for :users
  root to: 'static_pages#homepage'
  get 'static_pages/contact'
  get 'static_pages/about'
  
  resources :trainings
  resources :lessons
  resources :trainings_users, only: [:new, :create]
  
  scope '/dashboard' do
    resources :trainings do
      resources :sections do
        resources :lessons
      end
    end
  end

  get 'dashboard/index'
  get 'dashboard/student', to: 'dashboard#student'
  get 'dashboard/instructor' , to: 'dashboard#instructor'
  get 'dashboard/admin' , to: 'dashboard#admin'

  
end
