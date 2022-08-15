class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :area
  belongs_to :postage
  belongs_to :days
  has_one_attached :image

  with_options numericality: { other_than: 0, message: 'select' } do
    validates :category_id
    validates :status_id
    validates :area_id
    validates :postage_id
    validates :days_id
  end

  belongs_to :user
  has_one    :purchase

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

  validates :price, format: { with: /\A[0-9]+\z/, message: 'Price Half-width number' },
                    inclusion: { in: (300..9_999_999), message: 'Out of setting range' }
end
