class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|

      t.timestamps
      t.string     :name,               null: false
      t.text       :description,        null: false
      t.integer    :price,              null: false
      t.integer    :category_id,        null: false
      t.integer    :condition_id,       null: false
      t.integer    :delivery_charge_id, null: false
      t.integer    :days_to_ship_id,    null: false
      t.integer    :prefecture_id,      null: false
      t.references :user,               foreign_key: true
    end
  end
end
