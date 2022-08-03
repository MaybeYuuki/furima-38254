require 'rails_helper'
RSpec.describe User, type: :model do
    before do
      @user = FactoryBot.build(:user)
    end
  describe "ユーザー新規登録" do
    it "nicknameが空だと登録できない" do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it "emailが空では登録できない" do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it '重複したemailが存在する場合は登録できない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end
    it 'emaiは@を含まないと登録できない' do
      @user.email = 'testmail'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end
    it 'passwordが空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'passwordとencrypted_passwordが不一致では登録できない' do
      @user.password = '123456'
      @user.encrypted_password = '1234567'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password Include both letters and number")
    end
    it 'パスワードが5文字以下では登録できない' do
      @user.password = 'aaaaa'
      @user.password_confirmation = 'aaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end
    it '苗字がない場合は登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    it '名前がない場合は登録できない' do
      @user.family_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name can't be blank")
    end
    it '苗字は英語では入力できない' do
      @user.first_name = 'Make'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name Full-width characters')
    end
    it '氏名は英語では入力できない' do
      @user.family_name = 'Smith'
      @user.valid?
      expect(@user.errors.full_messages).to include('Family name Full-width characters')
    end
    it '苗字カナがない場合は登録できない' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end
    it '氏名カナがない場合は登録できない' do
      @user.family_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name kana can't be blank")
    end
    it '苗字のフリガナは平仮名は使えない' do
      @user.first_name_kana = 'たなか'
      @user.valid?  
      expect(@user.errors.full_messages).to include('First name kana Full-width katakana characters')
    end
    it '苗字のフリガナは漢字は使えない' do
      @user.first_name_kana = '田中'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kana Full-width katakana characters')
    end
    it '苗字のフリガナは英語は使えない' do
      @user.first_name_kana = 'tanaka'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kana Full-width katakana characters')
    end
    it '氏名のフリガナは平仮名は使えない' do
      @user.family_name_kana = 'たろう'
      @user.valid?
      expect(@user.errors.full_messages).to include('Family name kana Full-width katakana characters')
    end

    it '氏名のフリガナは漢字は使えない' do
      @user.family_name_kana = '太郎'
      @user.valid?
      expect(@user.errors.full_messages).to include('Family name kana Full-width katakana characters')
    end

    it '氏名のフリガナは英語は使えない' do
      @user.family_name_kana = 'tarou'
      @user.valid?
      expect(@user.errors.full_messages).to include('Family name kana Full-width katakana characters')
    end

    it '生年月日がないと登録できない' do
      @user.birth_date = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth date can't be blank")
    end
  end
end