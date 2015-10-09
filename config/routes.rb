Rails.application.routes.draw do
  root to: 'visitors#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :users do
    resources :posts
  end

  get 'discourse/sso' => 'discourse_sso#sso'
end
