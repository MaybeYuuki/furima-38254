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

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase).to be_valid
      end

      it 'building_nameは空でも保存できること' do
        @purchase.building_name = ''
        expect(@purchase).to be_valid
      end
    end

    context '内容に問題ある場合' do
      it '郵便番号がないと登録できない' do
        @purchase.postal_code = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("郵便番号を入力してください")
      end

      it '郵便番号にハイフンがないと登録できない' do
        @purchase.postal_code = '7777777'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('郵便番号が無効です。ハイフン(-)を含めて下さい')
      end

      it '都道府県についてのプルダウンが---だと登録できない' do
        @purchase.area_id = 0
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('都道府県選択して下さい')
        sleep(1)
      end

      it '市区町村がないと登録できない' do
        @purchase.municipalities = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("市区町村を入力してください")
      end

      it '番地がないと登録できない' do
        @purchase.address = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("番地を入力してください")
      end

      it '電話番号がないと登録できない' do
        @purchase.phone_number = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("電話番号を入力してください")
      end

      it '電話番号にハイフンがあると登録できない' do
        @purchase.phone_number = '000-0000-0000'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('電話番号が無効です')
      end

      it '電話番号が9桁以下では登録できない' do
        @purchase.phone_number = '000000000'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('電話番号が無効です')
      end

      it '電話番号が12桁以上では登録できない' do
        @purchase.phone_number = '000000000000'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('電話番号が無効です')
      end

      it 'userが紐付いていないと保存できないこと' do
        @purchase.user_id = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Userを入力してください")
      end

      it 'itemが紐付いていないと保存できないこと' do
        @purchase.item_id = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Itemを入力してください")
      end

      it 'tokenがないと登録できない' do
        @purchase.token = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("トークンを入力してください")
      end
    end
  end
end
