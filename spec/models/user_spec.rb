require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    it 'nicknameが空だと登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("ニックネームを入力してください")
    end
    it 'emailが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Eメールを入力してください")
    end
    it '重複したemailが存在する場合は登録できない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
    end
    it 'emaiは@を含まないと登録できない' do
      @user.email = 'testmail'
      @user.valid?
      expect(@user.errors.full_messages).to include('Eメールは不正な値です')
    end
    it 'passwordが空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードを入力してください")
    end
    it 'passwordとencrypted_passwordが不一致では登録できない' do
      @user.password = '123456'
      @user.encrypted_password = '1234567'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワード文字と数字の両方を含めて下さい')
    end
    it 'パスワードが5文字以下では登録できない' do
      @user.password = 'aaaaa'
      @user.password_confirmation = 'aaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
    end
    it '苗字がない場合は登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("苗字を入力してください")
    end
    it '名前がない場合は登録できない' do
      @user.family_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("名前を入力してください")
    end
    it '苗字は英語では入力できない' do
      @user.first_name = 'Make'
      @user.valid?
      expect(@user.errors.full_messages).to include('苗字全角で入力して下さい')
    end
    it '氏名は英語では入力できない' do
      @user.family_name = 'Smith'
      @user.valid?
      expect(@user.errors.full_messages).to include('名前全角で入力して下さい')
    end
    it '苗字カナがない場合は登録できない' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("苗字のカナを入力してください")
    end
    it '氏名カナがない場合は登録できない' do
      @user.family_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("名前のカナを入力してください")
    end
    it '苗字のフリガナは平仮名は使えない' do
      @user.first_name_kana = 'たなか'
      @user.valid?
      expect(@user.errors.full_messages).to include('苗字のカナ全角カタカナで入力して下さい')
    end
    it '苗字のフリガナは漢字は使えない' do
      @user.first_name_kana = '田中'
      @user.valid?
      expect(@user.errors.full_messages).to include('苗字のカナ全角カタカナで入力して下さい')
    end
    it '苗字のフリガナは英語は使えない' do
      @user.first_name_kana = 'tanaka'
      @user.valid?
      expect(@user.errors.full_messages).to include('苗字のカナ全角カタカナで入力して下さい')
    end
    it '氏名のフリガナは平仮名は使えない' do
      @user.family_name_kana = 'たろう'
      @user.valid?
      expect(@user.errors.full_messages).to include('名前のカナ全角カタカナで入力して下さい')
    end

    it '氏名のフリガナは漢字は使えない' do
      @user.family_name_kana = '太郎'
      @user.valid?
      expect(@user.errors.full_messages).to include('名前のカナ全角カタカナで入力して下さい')
    end

    it '氏名のフリガナは英語は使えない' do
      @user.family_name_kana = 'tarou'
      @user.valid?
      expect(@user.errors.full_messages).to include('名前のカナ全角カタカナで入力して下さい')
    end

    it '生年月日がないと登録できない' do
      @user.birth_date = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("誕生日を入力してください")
    end
  end
end
