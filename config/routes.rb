Rails.application.routes.draw do
  resources :articles, only: [:index, :show] do
    post :like
  end
end
