PolicyManager::Engine.routes.draw do

  get "documentation", to: "application#doc", as: :documentation

  get '/user_terms/pending', to: redirect('/users/dashboard')
  
  resources :user_portability_requests, only: [:index, :create, :destroy]

  resources :portability_requests, only: [:index, :destroy] do
    member do
      get :confirm
    end
  end
  
  resources :categories, only: [:show, :index] do 
    resources :terms, except: [:index]
  end

  resources :user_terms, only: [:show] do 
    collection do 
      put :accept_multiples
      get :blocking_terms
    end
    
    member do
      put :accept 
      put :reject 
    end
  end
  
  root 'categories#index'
end
