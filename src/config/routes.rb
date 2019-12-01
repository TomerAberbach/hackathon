# Maps URLs to controller actions
Rails.application.routes.draw do
  root to: redirect('/dashboard')
  # Dashboard devise routes
  scope :dashboard do
    devise_for :admins, path: 'admin', skip: :registrations
    as :admin do
      get 'admin/edit', to: 'devise/registrations#edit', as: 'edit_admin_registration'
      put 'admin', to: 'devise/registrations#update', as: 'admin_registration'
    end
  end

  # Dashboard routes
  namespace :dashboard do
    # Root dashboard route to sign in
    root to: redirect('/dashboard/admin/sign_in')

    # Resources
    resource :metadata, only: %i[show edit update]
    resources :sections
    resources :admins
  end

  devise_for :hackers, path: 'hackers'
end
