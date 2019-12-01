# Maps URLs to controller actions
Rails.application.routes.draw do
  root to: redirect('/dashboard')

  # Dashboard routes
  namespace :dashboard do
    # Root dashboard route to sign in
    root to: redirect('/dashboard/admins/sign_in')

    # Resources
    resource :metadata, only: %i[show edit update]
    resources :sections
    resources :admins
  end

  # Dashboard devise routes
  scope :dashboard do
    devise_for :admins, path: 'admin'
  end

  devise_for :hackers, path: 'hackers'
end
