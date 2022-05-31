Rails.application.routes.draw do
  root to: 'static_pages#homepage'
  get 'contactez-nous', to: 'static_pages#contact', as: 'static_pages/contact'
  get 'a-propos', to: 'static_pages#about', as: 'static_pages/about'
  get 'devenir-instructeur', to: 'static_pages#instructor', as: 'static_pages/instructor'
  
  devise_for :users, 
    path: '', 
    path_names: { 
      sign_in: 'connexion', 
      sign_out: 'déconnexion', 
      sign_up: 'inscription'
    }

  resources :trainings, as: :catalogue, path: :catalogue
  resources :lessons
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
