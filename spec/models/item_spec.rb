require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('public/images/sample1.jpg')
  end

  describe '#create' do
    it '必須項目を入力した上で出品ができる' do
      expect(@item).to be_valid
    end

    it '画像がないと登録できない' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end

    it '商品名がないと登録できない' do
      @item.name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end

    it '商品の説明がないと登録できない' do
      @item.explanation = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Explanation can't be blank")
    end

    it 'カテゴリーのプルダウンが---だと登録できない' do
      @item.category_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Category select')
    end

    it '商品の状態についてのプルダウンが---だと登録できない' do
      @item.status_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Status select')
    end

    it '配送料の負担についてのプルダウンが---だと登録できない' do
      @item.postage_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Postage select')
    end

    it '発送元の地域についてのプルダウンが---だと登録できない' do
      @item.area_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Area select')
    end

    it '発送までの日数についてのプルダウンが---だと登録できない' do
      @item.days_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Days select')
    end

    it '価格についての情報がないと登録できない' do
      @item.price = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end

    it '価格が300円以下だと登録できない' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include('Price Out of setting range')
    end

    it '価格が9999999円以上だと登録できない' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include('Price Out of setting range')
    end

    it '販売価格は半角数字以外では登録できない' do
      @item.price = '１０００'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price Out of setting range')
    end

    it 'userが紐づいていないと保存できない' do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.build(:item, user_id: @user.id)
      expect(@item).to be_valid
    end
  end
end
