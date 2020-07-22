Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Wildcard Page route which will show desktop and window
  get '/:page', to: "desktop#document"

  # Default index route
  root 'desktop#index'

end
