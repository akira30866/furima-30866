require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '商品の出品' do
    before do
     @item = FactoryBot.build(:item)
    end

    it 'name,description,image,price,category_id,condition_id,delivery_charge_id,days_to_ship_id,prefecture_idがあれば登録できること' do
      expect(@item).to be_valid
    end

    it 'nameが空だと登録できないこと' do
      @item.name = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end

    it 'descriptionが空だと登録できないこと' do
      @item.description = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Description can't be blank")
    end

    it 'imageが空だと登録できないこと' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end

    it 'priceが空だと登録できないこと' do
      @item.price = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank", "Price is not a number")
    end

    it 'priceが全角数字では登録できないこと' do
      @item.price = "５０００"
      @item.valid?
      expect(@item.errors.full_messages).to include("Price is not a number")
    end

    it 'priceが小数では登録できないこと' do
      @item.price = "500.9"
      @item.valid?
      expect(@item.errors.full_messages).to include("Price must be an integer")
    end

    it 'priceが300円未満では登録できないこと' do
      @item.price = "299"
      @item.valid?
      expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
    end

    it 'priceが9,999,999円より大きい場合は登録できないこと' do
      @item.price = "10000000"
      @item.valid?
      expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
    end

    it 'category_idが空だと登録できないこと' do
      @item.category_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Category can't be blank", "Category 選択してください")
    end

    it 'category_idが1の場合は登録できないこと' do
      @item.category_id = '1'
      @item.valid?
      expect(@item.errors.full_messages).to include("Category 選択してください")
    end

    it 'condition_idが空だと登録できないこと' do
      @item.condition_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Condition can't be blank", "Condition 選択してください")
    end
    
    it 'condition_idが１の場合は登録できないこと' do
      @item.condition_id = '1'
      @item.valid?
      expect(@item.errors.full_messages).to include("Condition 選択してください")
    end

    it 'prefecture_idが空だと登録できないこと' do
      @item.prefecture_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Prefecture can't be blank", "Prefecture 選択してください")
    end

    it 'prefecture_idが1の場合は登録できないこと' do
      @item.prefecture_id = '1'
      @item.valid?
      expect(@item.errors.full_messages).to include("Prefecture 選択してください")
    end

    it 'delivery_charge_idが空だと登録できないこと' do
      @item.delivery_charge_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Delivery charge can't be blank", "Delivery charge 選択してください")
    end

    it 'delivery_charge_idが1の場合は登録できないこと' do
      @item.delivery_charge_id = '1'
      @item.valid?
      expect(@item.errors.full_messages).to include("Delivery charge 選択してください")
    end

    it 'days_to_ship_idが空では登録できないこと' do
      @item.days_to_ship_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Days to ship can't be blank", "Days to ship 選択してください")
    end

    it 'days_to_ship-idが1の場合は登録できないこと' do
      @item.days_to_ship_id = '1'
      @item.valid?
      expect(@item.errors.full_messages).to include("Days to ship 選択してください")
    end

    it 'userが紐づいていないと登録できないこと' do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("User must exist")
    end

  end
end
