class ItemsController < ApplicationController
  before_action :authenticate_user!, unless: :devise_controller? # ログイン必須な時
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  
  def index
    @items = current_user.items
    @filter = params[:filter]

    # フィルターがある場合のみ絞り込む
    @items = @items.where(status: @filter) if @filter.present? && Item.statuses.key?(@filter)
  end

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.build(item_params)

    if @item.save
      redirect_to items_path, notice: '登録しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to items_path, notice: '更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy!
    redirect_to items_path, notice: "アイテムを削除しました", status: :see_other
  end

  private

  def set_item
    @item = current_user.items.find(params[:id])
  end

  def item_params
    params.require(:item).permit( :name, :price, :description, :release_date, :reservation_start_date, :reservation_end_date, :purchased_at, :status, :memo )
  end
end
