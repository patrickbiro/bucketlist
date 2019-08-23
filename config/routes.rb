Rails.application.routes.draw do

  get 'account/ideas'
  #First route allow to get to the page edit for the idea id = :id
  #Second route allow to update the idea with id = :id in the database

  get   '/ideas/:id/edit', to: 'ideas#edit', as: 'edit_idea'

  patch '/ideas/:id',      to: 'ideas#update', as: 'idea'
  #-------------------------

  root to: 'home#index'

  get 'home', to:'home#index'

  get 'home/index'

  get 'styles/atoms'

  get 'styles/molecules'

  get 'styles/organisms'

  get 'ideas/index'



  #Create the route to the page new Ideas and then create a route when posting new Idea
  get  '/ideas/new'

  post '/ideas/create'
  #-------------------------

  get '/ideas/:id/', to: 'ideas#show', as: 'show_idea'

  get 'styleguide', to:'styles#atoms'

  get 'styleguide/form/example', to:'styles#atoms'




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
