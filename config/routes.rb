Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'home#index'
  get 'noodles/calculate', to: 'noodles#index'
  post 'noodles/calculate'
  get 'distances/calculate', to: 'distances#index'
  post 'distances/calculate'
end
