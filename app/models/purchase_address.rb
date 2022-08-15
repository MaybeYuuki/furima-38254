class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :area_id, :municipalities, :address, :building_name, :phone_number, :price, :user_id

  with_options presence: true do
    validates :price, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 1000000, message: 'is invalid'}
    validates :user_id
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
  end
  validates :prefecture, numericality: {other_than: 0, message: "can't be blank"}

  def save
    purchase = Purchase.create(price: price, user_id: user_id)
    Address.create(postal_code: postal_code, area_id: area.id, municipalities: municipalities, house_number: house_number, building_name: building_name, address: :address)
  end
end