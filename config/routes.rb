Rails.application.routes.draw do

  devise_for :admins, skip: [:registrations], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers, controllers: {
    registrations: "customer/registrations",
    sessions: 'customer/sessions'
  }

  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'customers/sessions#guest_sign_in'
  end

  namespace :admin do
    resources :customers, only:[:show, :index, :edit, :update]
    resources :posts, only:[:show, :index, :edit, :update]
  end

  root to: "customer/homes#top"
  get '/about' => 'customer/homes#about'

  scope module: :customer do
    get 'customers/:id/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    patch 'customers/:id/withdraw' => 'customers#withdraw', as: 'withdraw'
    resources :customers, only:[:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'follow' => 'relationships#follow', as:'follow'
    end
    resources :posts, except:[:new] do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
  end

  get "search" => "searches#search"
end
