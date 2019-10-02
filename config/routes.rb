Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :customers do
        get '/find', to: "search#show"
        get '/find_all', to: "search#show_all"
      end

      namespace :invoice_items do
        get '/find', to: "search#show"
        get '/find_all', to: "search#show_all"
      end

      namespace :invoices do
        get '/find', to: "search#show"
        get '/find_all', to: "search#show_all"
      end

      namespace :items do
        get '/find', to: "search#show"
        get '/find_all', to: "search#show_all"
      end

      namespace :merchants do
        get '/find', to: "search#show"
        get '/find_all', to: "search#show_all"
      end

      resources :customers, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :merchants, only: [:index, :show]
      resources :transactions, only: [:index, :show]
    end
  end
end
