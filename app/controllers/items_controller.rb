class ItemsController < ApplicationController
  before_action :require_login, only: :new, alert: 'You need to sign in or sign up before continuing.'
  before_action :set_item, only: [:show, :edit, :update]
  def index
    @items = Item.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    item.update(item_params)
  end
  
  private

  def item_params
    params.require(:item).permit(:image, :name, :price, :postage_id, :category_id, :explanation, :status_id, :area_id,
                                 :days_id).merge(user_id: current_user.id)
  end

  def require_login
    redirect_to user_session_path, alert: 'You need to sign in or sign up before continuing.' unless user_signed_in?
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
