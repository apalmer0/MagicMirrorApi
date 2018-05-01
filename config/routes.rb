Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post "/todoist_webhook", to: "todoist_webhook#create"

  namespace :api do
    resources :items, only: [:index]
  end
end
