Rails.application.routes.draw do
  devise_for :users
  resources :users, except: :create
  post 'create_user' => 'users#create', as: :create_user
  get '/users_list', to: 'users#list', as: :users_list
  root to: 'users#index'

  resources :messages, except: [:new] do
    collection do
      get '/count_messages', to: 'messages#get_message_count'
      get '/load_messages', to: 'messages#load_messages', as: :load_messages
      get '/new/:rxuser_id', to: 'messages#new', as: :new
    end
  end
end
