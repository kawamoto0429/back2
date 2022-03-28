Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace 'api' do
    namespace 'v1' do
      get "formats/index", to: "formats#index"
      get "folders/todo", to: "folders#todo"
      get "folders/plan", to: "folders#plan"
      resources :folders 
      get "todoes/alone", to: "todoes#alone"
      resources :todoes do 
        get "complete"
      end
      get "plans/alone", to:"plans#alone"
      get "plans/find", to: "plans#find"
      resources :plans
      resources :users
      post "loginIn", to: "sessions#create"
      get "session", to: "sessions#index"
      get "logout", to: "sessions#destroy"
    end
  end
end
