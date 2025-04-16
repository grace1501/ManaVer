Rails.application.routes.draw do
  devise_for :users

  unauthenticated do
    root "pages#about"
  end
  
  authenticated :user do
    root "folders#index", as: :authenticated_root
  end

  resources :folders
  resources :versions, except: [:index]  
  
  get "about", { :controller => "pages", :action => "about"}
end
