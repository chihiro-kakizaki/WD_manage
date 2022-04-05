Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'posts#index'
  devise_for :users, controllers: {
        registrations: 'users/registrations'
}
  resources :users, only: [:show]
  resources :posts
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
