# Maps URLs to controller actions
Rails.application.routes.draw do
  # Dashboard devise routes
  scope :dashboard do
    devise_for :users, path: 'users'
  end

  # Dashboard routes
  namespace :dashboard do
    # Root dashboard route to sign in
    root to: redirect('/dashboard/users/sign_in')

    # Sets up dashboard routes
    resource :metadata, only: %i[show edit update]
  end

  devise_for :hackers, path: 'hackers'
end
