Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'stock#index'
  get 'stock/get_stock_info'=>'stock#get_stock_info'
  get 'stock/show_stock_info'=>'stock#show_stock_info'
end
