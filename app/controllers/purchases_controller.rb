class PurchasesController < ApplicationController
  def index
    @purchase = PurchaseAddress.new
  end

  def create
    @purchase = PurchaseAddress.new(purchase_params)
    if @purchase.valid?
      pay_item
      @purchase.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_address).permit(:postal_code, :area_id, :municipality, :building_name, :address, :house_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end
end
