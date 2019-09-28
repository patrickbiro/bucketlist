Rails.application.routes.draw do

  root to: 'home#index'
  scope '/:locale' do
    root to: 'home#index'
    get 'styles/atoms'

    get 'styles/molecules'

    get 'styles/organisms'
    get 'home', to:'home#index'

    get 'home/index'



    get 'account/ideas'
    get 'account', to:'account#edit'
    patch 'account', to:'account#update'
    get 'account/goals', to: 'account#goals', as: 'account_goals'




    get 'styleguide', to:'styles#atoms'

    get 'styleguide/form/example', to:'styles#atoms'

    #Resources Ideas with nested child resource comments

    resources :ideas do
      resources :comments
      resources :photos
    end

    resources :users, only: [:new, :create, :edit, :update] do
      resources :goals
    end

    resources :sessions, only: [:new, :create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
