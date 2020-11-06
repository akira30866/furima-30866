require 'rails_helper'

RSpec.describe Address, type: :model do
  # 各値のバリデーションについてはorder_address_spec.rbで確認
  describe 'アソシエーションの確認' do
    before do
      @address = FactoryBot.build(:address)
    end

    it 'orderに紐づいていないと保存できないこと' do
      @address.order = nil
      @address.valid?
      expect(@address.errors.full_messages).to include("Order must exist")
    end
  end
  
end
