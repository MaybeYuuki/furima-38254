class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :area
  belongs_to :postage
  belongs_to :days




  with_options numericality: { other_than: 1 , message: "can't be blank"} do
    validates :category_id
    validates :status_id
    validates :area_id
    validates :postage_id
    validates :days_id
  end

  belongs_to :user

  with_options presence: true do
    validates :image
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
