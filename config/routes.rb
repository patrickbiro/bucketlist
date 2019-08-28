Rails.application.routes.draw do

  get 'account/ideas'

  root to: 'home#index'

  get 'home', to:'home#index'

  get 'home/index'

  get 'styles/atoms'

  get 'styles/molecules'

  get 'styles/organisms'


  get 'styleguide', to:'styles#atoms'

  get 'styleguide/form/example', to:'styles#atoms'

  #Resources Ideas with nested child resource comments

  resources :ideas do
    resources :comments
  end




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
