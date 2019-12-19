# Maps URLs to controller actions
Rails.application.routes.draw do
  # Root routes
  root to: 'home#index'
  resource :hacker, only: %i[show]
  resource :mailing_list, only: %i[update]
  devise_for :hackers, path: 'hackers', controllers: {
    passwords: 'hackers/passwords',
    registrations: 'hackers/registrations',
    sessions: 'hackers/sessions'
  }

  # Dashboard devise routes
  scope :dashboard do
    devise_for :admins, path: 'admin', skip: %i[registrations invitations], controllers: {
      passwords: 'admins/passwords',
      sessions: 'admins/sessions',
    }
    as :admin do
      get 'admin/edit', to: 'admins/registrations#edit', as: 'edit_admin_registration'
      put 'admin', to: 'admins/registrations#update', as: 'admin_registration'
      post 'admin/invitation', to: 'admins/invitations#create', as: 'admin_invitation'
      put 'admin/invitation', to: 'admins/invitations#update', as: 'update_admin_invitation'
      get 'admin/invitation/accept', to: 'admins/invitations#edit', as: 'accept_admin_invitation'
    end
  end

  # Dashboard routes
  namespace :dashboard do
    # Root dashboard route to sign in
    root to: redirect('/dashboard/admin/sign_in')

    # Resources
    resource :metadata, only: %i[show edit update]
    resources :admins, only: %i[index create new destroy]
    resources :sections do
      patch :up, :down, :publish, :unpublish, on: :member
    end
    resource :mailing_list, only: %i[show destroy] do
      get :email
      post :email, to: 'mailing_lists#deliver'
    end
    resources :hackers, only: %i[index show destroy] do
      collection do
        get :resumes, :email
        post :email, to: 'hackers#deliver'
      end
      patch :check_in, :uncheck_in, on: :member
    end
  end
end
