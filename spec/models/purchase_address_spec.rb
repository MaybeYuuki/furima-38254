require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.build(:item)
      @item.image = fixture_file_upload('public/images/sample1.jpg')
      @item.save
      @purchase = FactoryBot.build(:purchase_address, item_id: @item.id, user_id: @user.id)
      sleep 0.1
    end

    it 'すべての値が正しく入力されていれば保存できること' do
      expect(@purchase).to be_valid
    end

    it '郵便番号がないと登録できない' do
      @purchase.postal_code = ''
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("Postal code can't be blank")
    end

    it '郵便番号にハイフンがないと登録できない' do
      @purchase.postal_code = '7777777'
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
    end

    it '都道府県についてのプルダウンが---だと登録できない' do
      @purchase.area_id = 0
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include('Area select')
      sleep(1)
    end

    it '市区町村がないと登録できない' do
      @purchase.municipalities = ''
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("Municipalities can't be blank")
    end

    it '番地がないと登録できない' do
      @purchase.address = ''
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("Address can't be blank")
    end

    it '電話番号がないと登録できない' do
      @purchase.phone_number = ''
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("Phone number can't be blank")
    end

    it '電話番号にハイフンがあると登録できない' do
      @purchase.phone_number = '000-0000-0000'
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include('Phone number is invalid')
    end

    it 'userが紐付いていないと保存できないこと' do
      @purchase.user_id = ''
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("User can't be blank")
    end

    it 'itemが紐付いていないと保存できないこと' do
      @purchase.item_id = ''
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("Item can't be blank")
    end
  end
end
