DoctorRails::Engine.routes.draw do
  root :to => 'checks#index'
  resources :checks, :only => [:index]
end
