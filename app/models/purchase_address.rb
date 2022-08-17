class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :area_id, :municipalities, :address, :building_name, :phone_number, :item_id, :user_id, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :municipalities
    validates :address
    validates :token
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid' }
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
  end
  validates :area_id, numericality: { other_than: 0, message: 'select' }

  def save
    purchase = Purchase.create(item_id: item_id, user_id: user_id)
    Address.create(postal_code: postal_code, area_id: area_id, municipalities: municipalities, phone_number: phone_number,
                   building_name: building_name, address: address, purchase_id: purchase.id)
  end
end
