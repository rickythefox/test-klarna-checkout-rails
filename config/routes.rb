Rails.application.routes.draw do
  get '/', to: 'home#index'
  get 'confirm', to: 'home#confirm'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
