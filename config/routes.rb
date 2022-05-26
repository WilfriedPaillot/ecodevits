Rails.application.routes.draw do
  devise_for :users
  root to: 'static_pages#homepage'
  get 'static_pages/contact'
  get 'static_pages/about'
  
  resources :trainings, as: :catalogue, path: :catalogue
  resources :lessons
  #old resources :trainings_users, only: [:new, :create] 
  resources :user_trainings, only: [:new, :create, :update]
  
  scope '/dashboard' do
    resources :users do
      member do
        put :set_approval
        get :reject
      end
    end
    resources :trainings do
      resources :sections do
        resources :lessons
      end
    end
  end

  get 'dashboard/index'
  get 'dashboard/student', to: 'dashboard#student'
  get 'dashboard/student/training/:id', to: 'dashboard#student', as: :student_training
  get 'dashboard/instructor' , to: 'dashboard#instructor'
  get 'dashboard/admin' , to: 'dashboard#admin'
  get 'dashboard/admin/users', to: 'dashboard#admin', as: :admin_users
  
end
