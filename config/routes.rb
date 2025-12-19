Rails.application.routes.draw do
  devise_for :users

  # ルートパスをitems一覧に設定
  root "items#index"

  # アイテムのCRUD操作
  resources :items do
    resources :items
  end

  # ヘルスチェック用
  get "up" => "rails/health#show", as: :rails_health_check
end