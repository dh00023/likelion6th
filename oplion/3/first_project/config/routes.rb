Rails.application.routes.draw do
  root 'home#index'
  get 'attack',to: 'home#attack'
  get 'defense'=> 'home#defense'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
