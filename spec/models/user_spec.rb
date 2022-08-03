require 'rails_helper'
RSpec.describe User, type: :model do
  describe "ユーザー新規登録" do
    it "nameが空だと登録できない" do
      user = FactoryBot.build(:user)
      user.name = ''
      user.valid?
      expect(user.errors.full_messages).to include("Name can't be blank")
    end
    it "emailが空では登録できない" do
      user = FactoryBot.build(:user)
      user.email = ''
      user.valid?
      expect(user.errors.full_messages).to include("Email can't be blank")
    end
    it "メールアドレスが一意性出ないと登録できない"

  end
end