Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post "/todoist_webhook", to: "todoist_webhook#create"
  post "/google_images_webhook", to: "google_images_webhook#create"

  namespace :api do
    resources :forecast_items, only: [:index]
    resources :images, only: [:index]
    resources :items, only: [:index]
    resources :trivia_items, only: [:index]
    put 'items', controller: 'items', action: :update
  end
end
