Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'auth/registrations'
  }

  resources :messages, only: %i[index] do
    member do
      resources :likes, only: %i[create]
    end
  end

  resources :likes, only: %i[destroy]
end
