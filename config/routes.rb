Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'public/users/registrations',
    sessions: 'public/users/sessions'
  }
  devise_for :admins, controllers: {
    sessions: 'admin/admins/sessions'
  }
  
  namespace :admin do
    root "home#top"
    resources :users, only: [:index, :show, :destroy]
  end
  
  scope module: :public do
    root "home#top"
    resources :users, only: [:index, :show, :edit, :update, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resource :relationships, only: [:create, :destroy]
    end
    resources :posts do
      resources :comments, only: [:create]
    end
    resources :comments, only: [:edit, :update, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
