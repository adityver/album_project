  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  
  get 'tags/index'
  devise_for :users
  root to: "albums#index"
  resources :albums
  resources :tags
  # get '/filter', to:"albums#tag_filter"

  resources :albums do
    member do
     delete :delete_image_attachment
    end
  end

end
