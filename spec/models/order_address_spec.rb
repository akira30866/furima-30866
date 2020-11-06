require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe "商品の購入/住所情報の登録" do
    before do
      @order_address = FactoryBot.build(:order_address)
    end

    it '全ての値が正しく入力されている場合は保存できること' do
      expect(@order_address).to be_valid
    end
  end
end
