Rails.application.routes.draw do
  root to: 'visitors#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :users do
    resources :posts
  end

  devise_scope :user do
    get '/sso' => 'users/sessions#sso'
  end
end
