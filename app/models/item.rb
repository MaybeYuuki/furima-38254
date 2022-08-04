class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  validates :category_id, numericality: { other_than: 1 , message: "can't be blank"}
  belongs_to :user

  with_options presence: true do
    validates :name
    validates :price
    validates :postage_id
    validates :explanation
    validates :status_id
    validates :area_id
    validates :days_id
    validates :category_id
  end
end
