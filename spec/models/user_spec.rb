require 'rails_helper'

RSpec.describe User, type: :model do
  describe '新規登録/ユーザー情報' do
    before do
      @user = FactoryBot.build(:user)
    end

    it 'nickname,email,password,password_confirmation,family_name,first_name,family_name_kana,first_name_kana,birthdayがあれば登録できること' do
      expect(@user).to be_valid
    end

    it 'nicknameが空だと登録できないこと' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'emailが空だと登録できないこと' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'emailが重複していると登録できないこと' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end

    it 'emailには@が含まれていないと登録できないこと' do
      @user.email = 'test'
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end

    it 'パスワードが空では登録できないこと' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'パスワードが英数字を含む6文字以上ならば登録できること' do
      @user.password = 'aaa111'
      @user.password_confirmation = 'aaa111'
      expect(@user).to be_valid
    end

    it 'パスワードが5文字以下なら登録できないこと' do
      @user.password = 'aaa11'
      @user.password_confirmation ='aaa11'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it 'パスワードが6文字以上でも英字のみでは登録できないこと' do
      @user.password = 'aaaaaa'
      @user.password_confirmation = 'aaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password 英字と数字の両方を含めて設定してください")
    end

    it 'パスワードが6文字以上でも数字のみでは登録できないこと' do
      @user.password = '111111'
      @user.password_confirmation = '111111'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password 英字と数字の両方を含めて設定してください")
    end

    it 'パスワードとパスワード（確認用）が一致しないと登録できないこと' do
      @user.password = 'aaa111'
      @user.password_confirmation = 'bbb111'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end

end
