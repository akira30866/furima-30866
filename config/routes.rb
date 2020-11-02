Rails.application.routes.draw do
  devise_for :users
  root to: "items#index" 
  # 機能実装ごとにアクションは設定する
  resources :items, only: [:index, :new]
end
