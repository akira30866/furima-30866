class ItemsController < ApplicationController
  # アクションの設定については実装に応じて追記
  before_action :authenticate_user!, except: [:index]
  def index
  end

  def new
  end

  def create
  end
end
