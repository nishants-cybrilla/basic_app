Rails.application.routes.draw do
  root to: 'visitors#index'

  get 'users/:id/new_topic' => 'users#new_topic', as: 'users_new_topic'
  post 'users/:id/create_topic' => 'users#create_topic', as: 'users_create_topic'
  get 'users/fb_tagging' => 'users#facebook_tagging'
  get 'users/user_list' => 'users#user_list'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :users do
    resources :posts
  end

  get 'discourse/sso' => 'discourse_sso#sso'
end
