Rails.application.routes.draw do
  root "folders#index"
  devise_for :users
  
  resources :folders
  resources :versions  
  
end
