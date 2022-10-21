Rails.application.routes.draw do

  root to: 'homes#top'
  get '/about' => 'homes#about'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # 以下はユーザー
  devise_for :users, controllers: {
    registrations: "public/registrations",
    passwords: 'public/passwords',
    sessions: 'public/sessions'
  }
  scope module: 'public' do

    resources :users, only: [:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
      get 'confirm'
      patch 'withdraw'
    end

    resources :posts, only: [:new, :create, :update, :destroy, :index, :show, :edit] do
      resource :favorites, only: [:create,:destroy]
      resource :bookmarks, only: [:create,:destroy, :index]
      resources :post_comments, only: [:create,:destroy]
    end

    resources :chats, only: [:create, :show, :index]



  end

  # 以下は管理者
  devise_for :admin, only: [:sessions, :password], :controllers => {
    :sessions => 'admin/sessions'
  }

end
