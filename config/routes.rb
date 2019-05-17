Rails.application.routes.draw do
  root "static_pages#home"

  get "/registration", to: "accounts#new"
  get "/profile", to: "accounts#show"
  get "/changepassword", to: "accounts#edit"
  get "/login", to: "sessions#new"

  post "/registration", to: "accounts#create"
  post "/login", to: "sessions#create"

  patch "/changepassword", to: "accounts#update"

  delete "/logout", to: "sessions#destroy"

  resources :account_activations, only: %i(edit)
  resources :password_resets, except: %i(show index destroy)

  resources :locations, only: %i(index show new) do
    resources :reviews, only: [ :create, :destroy]
  end

  namespace :admin do
    resources(:users){get "search", on: :collection}
    resources(:location_types){get "search", on: :collection}
    resources(:services, except: :destroy){get "search", on: :collection}
    resources(:bed_details, except: :destroy){get "search", on: :collection}

    root "static_pages#home"
  end

  namespace :manager do
    root "static_pages#home"
    resources :locations, except: :index do
      get "search", on: :collection
      resources :reviews, only: [:show]
      resources(:rooms, except: :destroy){get "search", on: :collection}
    end
  end
end
