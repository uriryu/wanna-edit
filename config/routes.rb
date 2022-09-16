Rails.application.routes.draw do


  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :admin do
    
    resources :users, only: [:index, :show, :edit, :update]
  end

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  scope module: :public do
    root to: "homes#top"
    
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
