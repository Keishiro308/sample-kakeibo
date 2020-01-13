Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  get '/rooms/:room_id/items/new', to: 'items#new', as: :new_item
  get '/rooms/:room_id/items/:id/edit', to: 'items#edit', as: :edit_item
  get '/rooms/:id/:date', to: 'rooms#show_date', as: :room_date
  get '/rooms/:id/invites/new', to: 'invites#new', as: :new_invite
  get '/users/:id/info', to: 'users#info', as: :user_info
  resources :users, only: :show
  resources :items
  resources :rooms
  resources :invites
  post '/invites/:id/rooms/add', to: 'invites#add'
  root to: 'users#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
