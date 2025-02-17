Rails.application.routes.draw do
  root to: "questions#index"

  devise_for :users, path_names: { sign_in: :login, sign_out: :logout }

  get 'badges', to: 'users#badges'

  resources  :questions do
    resources :answers, shallow: true, except: %i[index] do
      patch :best, on: :member
    end
  end

  resources :attachments, only: %i[destroy]
end
