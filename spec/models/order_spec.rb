require 'rails_helper'

RSpec.describe Order, type: :model do
  # 各値のバリデーションについてはorder_address_spec.rbで確認
  describe 'アソシエーションの確認' do
    before do
      @order = FactoryBot.build(:order)
    end

    it 'userに紐づいていなければ保存できないこと' do
      @order.user = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("User must exist")
    end

    it 'itemに紐づいていなければ保存できないこと' do
      @order.item = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Item must exist")
    end
  end
end
