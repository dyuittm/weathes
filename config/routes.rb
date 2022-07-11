Rails.application.routes.draw do

  devise_for :admins, skip: [:registrations], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers, controllers: {
    registrations: "customer/registrations",
    sessions: 'customer/sessions'
  }

  namespace :admin do
    resources :customers, only:[:show, :index, :edit, :update]
    resources :posts, only:[:show, :index, :edit, :update]
  end

  root to: "customer/homes#top"
  get '/about' => 'customer/homes#about'

  scope module: :customer do
    resources :customers, only:[:show, :edit, :update] do
      get 'customers/:id/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
      patch 'customers/:id/withdraw' => 'customers#withdraw', as: 'withdraw'
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as:'followings'
      get 'followers' => 'relationships#followers', as:'followers'
    end
    resources :posts, except:[:new] do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
  end

  get "search" => "searches#search"

end
