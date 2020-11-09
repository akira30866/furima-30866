require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe "商品の購入/住所情報の登録" do
    before do
      @order_address = FactoryBot.build(:order_address)
    end

    it '全ての値が正しく入力されている場合は保存できること' do
      expect(@order_address).to be_valid
    end

    it 'building_numberが空でも保存できること' do
      @order_address.building_number = nil
      expect(@order_address).to be_valid
    end

    it 'phone_numberが10桁でも保存できること' do
      @order_address.phone_number = '0901234567'
      expect(@order_address).to be_valid
    end

    it 'tokenが空だと保存できないこと' do
      @order_address.token = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Token can't be blank")
    end

    it 'postal_numberが空だと保存できないこと' do
      @order_address.postal_number = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal number can't be blank")
    end

    it 'prefecture_idが空だと保存できないこと' do
      @order_address.prefecture_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Prefecture 選択してください")
    end

    it 'cityが空だと保存できないこと' do
      @order_address.city = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("City can't be blank")
    end

    it 'house_numberが空だと保存できないこと' do
      @order_address.house_number = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("House number can't be blank")
    end

    it 'phone_numberが空だと保存できないこと' do
      @order_address.phone_number = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
    end

    it 'postal_numberに-がなければ保存できないこと' do
      @order_address.postal_number = '1234567'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal number is invalid")
    end

    it 'postal_numberが-入り７桁出なければ保存できないこと' do
      @order_address.postal_number = '12-345'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal number is invalid")
    end

    it 'prefecture_idが1より大きくないと保存できないこと' do
      @order_address.prefecture_id = 1
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Prefecture 選択してください")
    end

    it 'phone_numberに-があると保存できないこと' do
      @order_address.phone_number = '090-1234-5678'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number is invalid")
    end

    it 'phone_numberが12桁以上の場合は保存できないこと' do
      @order_address.phone_number = '090123456789'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number is invalid")
    end

    it 'phone_numberが9桁以下の場合は保存できないこと' do
      @order_address.phone_number = '090123456'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number is invalid")
    end
  end
end
