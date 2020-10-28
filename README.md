# README

## usersテーブル

| Columns          | Type   | Options     |
| ---------------- | ------ | ----------- |
| nickname         | string | null: false |
| email            | string | null: false |
| password         | string | null: false |
| family_name      | string | null: false |
| first_name       | string | null: false |
| family_name_kana | string | null: false |
| first_name_kana  | string | null: false |
| birthday         | date   | null: false |

### Association

- has_many :items
- has_many :orders

## itemsテーブル
| Columns            | Type       | Options                       |
| ------------------ | ---------- | ----------------------------- |
| name               | string     | null:false                    |
| description        | text       | null:false                    |
| price              | integer    | null:false                    |
| category_id        | integer    | null:false                    |
| condition_id       | integer    | null:false                    |
| delivery_charge_id | integer    | null:false                    |
| days_to_ship_id    | integer    | null:false                    |
| prefecture_id      | integer    | null:false                    |
| user               | references | null:false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order
- belongs_to_active_hash :category
- belongs_to_active_hash :condition
- belongs_to_active_hash :delivery_charge
- belongs_to_active_hash :days_to_ship
- belongs_to_active_hash :prefecture

## ordersテーブル

| Columns | Type       | Option                        |
| ------- | ---------- | ----------------------------- |
| user    | references | null:false, foreign_key: true |
| item    | references | null:false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :address

## addressesテーブル

| Columns         | Type       | Option                        |
| ----------------| ---------- | ----------------------------- |
| postal_number   | string     | null: false                   |
| prefecture_id   | integer    | null: false                   |
| city            | string     | null: false                   |
| house_number    | string     | null: false                   |
| building_number | string     |                               |
| phone_number    | string     | null: false                   |
| order           | references | null:false, foreign_key: true |

### Association
- belongs_to :order
- belongs_to_active_hash :prefecture

## 以下ActiveHashとActiveStorage

### ActiveHash
| Model           |
| --------------- |
| category        |
| condition       |
| delivery_charge |
| days_to_ship    |
| prefecture      |

- 各々のカラムのtypeはstring,optionはnull: false

### ActiveStorage
- image(itemモデル)