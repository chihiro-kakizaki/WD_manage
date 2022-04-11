Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'home#index'
  devise_for :users, controllers: {
        registrations: 'users/registrations'
}
  resources :users, only: %i[show]
  resources :posts do
    collection do
      get 'search'
    end
  end
  resources :favorites, only: %i[create destroy]
  resources :posts, only: %i[index] do
    member do
      get :favorites
    end
  end
  post 'favorite/:id', to: 'favorites#create', as: 'create_favorite'
  delete 'favorite/:id', to: 'favorites#destroy', as: 'destroy_favorite' 
  resources :pairs do
    resources :tasks
  end
  resources :home, only: %i[index]
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
