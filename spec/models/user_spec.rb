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

  describe '新規登録/本人情報' do
    before do
      @user = FactoryBot.build(:user)
    end
    
    # family_nameに関する記述

    it 'family_nameが空だと登録できないこと' do
      @user.family_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name can't be blank", "Family name 全角（漢字・ひらがな・カタカナ）で入力してください")
    end

    it 'family_nameに英字が入っていると登録できないこと' do
      @user.family_name = '山da'
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name 全角（漢字・ひらがな・カタカナ）で入力してください")
    end

    it 'family_nameに数字が入っていると登録できないこと' do
      @user.family_name ='山1'
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name 全角（漢字・ひらがな・カタカナ）で入力してください")
    end

    it 'family_nameに記号が入っていると登録できないこと' do
      @user.family_name ='山＠田'
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name 全角（漢字・ひらがな・カタカナ）で入力してください")
    end

    it 'family_nameに半角文字が入っていると登録できないこと' do
      @user.family_name ='山ﾀﾞ'
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name 全角（漢字・ひらがな・カタカナ）で入力してください")
    end

    # first_nameに関する記述

    it 'first_nameが空だと登録できないこと' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank", "First name 全角（漢字・ひらがな・カタカナ）で入力してください")
    end

    it 'first_nameに英字が入っていること登録できないこと' do
      @user.first_name ='たrou'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name 全角（漢字・ひらがな・カタカナ）で入力してください")
    end

    it 'first_nameに数字が入っていると登録できないこと' do
      @user.first_name ='た1'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name 全角（漢字・ひらがな・カタカナ）で入力してください")
    end

    it 'first_nameに記号が入っていると登録できないこと' do
      @user.first_name ='太＠郎'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name 全角（漢字・ひらがな・カタカナ）で入力してください")
    end

    it 'first_nameに半角文字が入っていると登録できないこと' do
      @user.first_name ='ﾀロウ'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name 全角（漢字・ひらがな・カタカナ）で入力してください")
    end

    # family_name_kanaに関する記述

    it 'family_name_kanaが空だと登録できないこと' do
      @user.family_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name kana can't be blank","Family name kana 全角カタカナで入力してください")
    end

    it 'family_name_kanaに英字が入っていると登録できないこと' do
      @user.family_name_kana = 'yamaダ'
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name kana 全角カタカナで入力してください")
    end

    it 'family_name_kanaに数字が入っていると登録できないこと' do
      @user.family_name_kana = '1ダ'
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name kana 全角カタカナで入力してください")
    end

    it 'family_name_kanaに平仮名が入っていると登録できないこと' do
      @user.family_name_kana = 'やまダ'
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name kana 全角カタカナで入力してください")
    end

    it 'family_name_kanaに漢字が入っていると登録できないこと' do
      @user.family_name_kana = '山ダ'
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name kana 全角カタカナで入力してください")
    end

    it 'family_name_kanaに記号が入っていると登録できないこと' do
      @user.family_name_kana = 'ヤマ＠ダ'
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name kana 全角カタカナで入力してください")
    end

    it 'family_name_kanaに半角文字が入っていると登録できないこと' do
      @user.family_name_kana = 'ﾔﾏダ'
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name kana 全角カタカナで入力してください")
    end

    # first_name_kanaに関する記述
    it 'first_name_kanaが空だと登録できないこと' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank","First name kana 全角カタカナで入力してください")
    end

    it 'first_name_kanaに英字が入っていると登録できないこと' do
      @user.first_name_kana = 'taroウ'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana 全角カタカナで入力してください")
    end

    it 'first_name_kana数字が入っていると登録できないこと' do
      @user.first_name_kana = '1ウ'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana 全角カタカナで入力してください")
    end

    it 'first_name_kanaに平仮名が入っていると登録できないこと' do
      @user.first_name_kana = 'たろウ'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana 全角カタカナで入力してください")
    end

    it 'first_name_kanaに漢字が入っていると登録できないこと' do
      @user.first_name_kana = '太ロウ'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana 全角カタカナで入力してください")
    end

    it 'first_name_kanaに記号が入っていると登録できないこと' do
      @user.first_name_kana = 'タロ＠ウ'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana 全角カタカナで入力してください")
    end

    it 'first_name_kanaに半角文字が入っていると登録できないこと' do
      @user.first_name_kana = 'ﾀﾛウ'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana 全角カタカナで入力してください")
    end

    # birthdayに関する記述
    it 'birthdayが空だと登録できないこと' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end

  end
end
