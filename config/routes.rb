Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    get '/users', to: 'users#index', as: 'users_index'
    get '/user/:id', to: 'users#show', as: 'show_user'
    post '/user', to: 'users#create', as: 'create_user'
    put '/user/:id', to: 'users#update', as: 'update_user'
    delete '/user/:id', to: 'users#destroy', as: 'destroy_user'
    get '/typeahead/:input', to:'users#search', as: 'search_user'
  end
end
