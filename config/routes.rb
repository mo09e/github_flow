Rails.application.routes.draw do
  resources :blogs do
    collection do
      post :confirm
      # patch :confirm
      # patch '/blogs', to: 'blogs#confirm'
    end
  end
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
end
