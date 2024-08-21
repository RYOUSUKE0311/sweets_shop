Rails.application.routes.draw do
  namespace :admin do
    get 'home/top'
  end
  namespace :public do
    get 'home/top'
  end
  devise_for :users, controllers: {
    registrations: 'public/users/registrations',
    sessions: 'public/users/sessions'
  }
  devise_for :admins, controllers: {
    sessions: 'admin/admins/sessions'
  }
  
  namespace :admin do
    root "home#top"
  end
  
  scope module: :public do
    root "home#top"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
