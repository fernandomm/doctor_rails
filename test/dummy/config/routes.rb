Rails.application.routes.draw do

  mount DoctorRails::Engine => "/doctor_rails"

  match 'failing_checks', :to => 'failing_checks#index'
  match 'working_checks', :to => 'working_checks#index'
end
