Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Stocks Resource
  resources :stocks, only: [ :index, :show ]
  get '/stocks/:id/valuation', to: "stocks#valuation", as: :valuation, defaults: {format: :json}

  # Wildcard Page route which will show desktop and window
  get '/blog/:post', to: "desktop#post", as: :post
  get '/:page', to: "desktop#page", as: :page

  # Default index route
  root 'desktop#index'

end
