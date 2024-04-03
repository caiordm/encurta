Rails.application.routes.draw do
  resources :urls
  
  get '/:url_hash', to: 'urls#redirecter'
end
