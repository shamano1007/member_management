Rails.application.routes.draw do
  root 'home#show'

  devise_for :users, skip: :all
  devise_scope :user do
    get :login, to: 'users/sessions#new', as: :new_user_session
    post :login, to: 'users/sessions#create', as: :user_session
    delete :logout, to: 'users/sessions#destroy', as: :destroy_user_session
  end

  namespace :admin do
    resources :users
  end

end
