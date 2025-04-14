Rails.application.routes.draw do
  resources :folders
  devise_for :users
  
end
