Rails.application.routes.draw do
  root to: "questions#index"

  devise_for :users, path_names: { sign_in: :login, sign_out: :logout }

  resources  :questions do
    resources :answers, shallow: true, except: %i[index edit]
  end
end
