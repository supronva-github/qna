Rails.application.routes.draw do
  resources  :questions do
    resources :answers, shallow: true, except: %i[index edit destroy]
  end
end
