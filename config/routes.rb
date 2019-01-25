Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'login-facebook', to: 'oauth#pull_redirect_url'
  get 'auth/:provider/callback', to: 'oauth#identify_network_entry'
  get '/auth/failure' => 'oauth#failure'
end
