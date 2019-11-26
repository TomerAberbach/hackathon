# Maps URLs to controller actions
Rails.application.routes.draw do
  root to: redirect('/dashboard')
  # Dashboard devise routes
  scope :dashboard do
    devise_for :users, path: 'users', skip: :registrations
    as :user do
      get 'users/edit', to: 'devise/registrations#edit', as: 'edit_user_registration'
      put 'users', to: 'devise/registrations#update', as: 'user_registration'
    end
  end

  # Dashboard routes
  namespace :dashboard do
    # Root dashboard route to sign in
    root to: redirect('/dashboard/users/sign_in')

    # Resources
    resource :metadata, only: %i[show edit update]
    resources :sections
  end

  devise_for :hackers, path: 'hackers'
end
