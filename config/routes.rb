Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Wildcard Page route which will show desktop and window
  get '/:page', to: "desktop#page", as: :page
  get '/blog/:post', to: "desktop#post", as: :post

  resources :stocks, only: [ :index, :show ]

  # Default index route
  root 'desktop#index'

end
