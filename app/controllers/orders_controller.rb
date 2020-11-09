class OrdersController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :find_item
  before_action :move_to_root_path, only: :index

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_address_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end
  
  private
  
  def order_address_params
    params.require(:order_address).permit(:postal_number, :prefecture_id, :city, :house_number, :building_number, :phone_number).merge(item_id: params[:item_id], user_id: current_user.id, token: params[:token])
  end

  def find_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount:   @item.price,
      card:     order_address_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_root_path
    if user_signed_in? && current_user.id == @item.user.id
      redirect_to root_path
    end
  end
  

end
