Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: {
        registrations: 'users/registrations',
        confirmations: 'users/confirmations'
}

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    post 'users/admin_guest_sign_in', to: 'users/sessions#admin_guest_sign_in'
    get '/users', to: 'devise/registrations#new'
  end

  resources :users, only: %i[show] do
    member do
      get :favorites
    end
  end

  resources :posts 

  resources :favorites, only: %i[create destroy]

  post 'favorite/:id', to: 'favorites#create', as: 'create_favorite'
  delete 'favorite/:id', to: 'favorites#destroy', as: 'destroy_favorite' 
 
  resources :pairs do
    resources :tasks do
      resources :comments
    end
  end

  resources :home, only: %i[index]

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
