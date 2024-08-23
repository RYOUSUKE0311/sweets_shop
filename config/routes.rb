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
      resource :relationships, only: [:create, :destroy]
      member do
        get :favorites
        get :followings
        get :followers
      end
    end
    resources :posts, only: [:show, :create, :edit, :update, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create]
    end
    get 'posts' => redirect("/")
    resources :comments, only: [:edit, :update, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
