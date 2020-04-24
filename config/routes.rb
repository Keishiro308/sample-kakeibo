Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :users, only: :show do
    member do
      get 'info', to: 'users#info', as: :info
    end
  end

  resources :rooms do
    member do
      delete 'exit', to: 'rooms#exit', as: :exit
    end
    resources :invites, only: [:new]
    resources :items, only: [:new, :edit]
  end
  resources :items, except: :new

  get '/rooms/:id/:date', to: 'rooms#show_date', as: :room_date

  resources :invites, except: [:new, :update, :edit, :show, :index] do
    member do
      post '/rooms/add', to: 'invites#add'
    end
  end
  
  root to: 'users#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
