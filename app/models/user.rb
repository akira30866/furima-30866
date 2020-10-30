class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i
  VALID_NAME_REGEX = /\A[ぁ-んァ-ン一-龥]+\z/
  VALID_NAME_KANA_REGEX = /\A[ァ-ン]+\z/

  validates :password,                         format: {with:VALID_PASSWORD_REGEX, message:"英字と数字の両方を含めて設定してください"}
  
  with_options presence: true do
    validates :nickname
    validates :birthday

    with_options format: {with:VALID_NAME_REGEX, message:"全角（漢字・ひらがな・カタカナ）で入力してください"} do
      validates :family_name
      validates :first_name
    end

    with_options format: {with:VALID_NAME_KANA_REGEX, message:"全角カタカナで入力してください"} do
      validates :family_name_kana
      validates :first_name_kana
    end
  end
end
