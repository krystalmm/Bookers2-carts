Rails.application.routes.draw do
  get 'carts/index'
  namespace :admins do
    get 'homes/top'
  end
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }

  get 'chats/show'
  get 'user_rooms/show'
  get 'rooms/show'
  get 'rooms/create'
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
  }
  # ログインと新規登録の時の指定

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get 'home/about' => "homes#about"
  post 'create/:id' => 'relationships#create', as:'follow'
  post 'destroy/:id' => 'relationships#destroy', as:'unfollow'
  get '/search' => 'search#search'
  resources :users, only: [:index, :show, :edit, :update]  do
    member do
      get :following, :followers
    end
  end

  # ————DM機能—————————————————————————————————
  resources :rooms, only: [:show, :create]
  resources :user_rooms, only: [:show, :create]
  get 'chat/:id' => 'chats#show', as: 'chat'
  resources :chats, only: [:create]
  # ——————カート内機能——————————————————————————
  resources :carts, only: [:index, :create, :update, :destroy]
  # ————————————————————————————————————————————

  resources :orders, only: [:new, :create, :index, :show] do
    collection do
      get :confirm
      get :success
    end
  end

  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
end
