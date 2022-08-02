## usersテーブル

| Column             | Type   | Options                  |
| nickname           | string | null: false              |
| email              | string | null: false,unique: true |
| password           | string | null: false              |
| encrypted_password | string | null: false              |
| first_name         | string | null: false              |
| family_name        | string | null: false              |
| first_name_kana    | string | null: false              |
| family_name_kana   | string | null: false              |
| birth_date         | date   | null: false              |

### Association
- has_many :items
- has_many :purchases

## itemsテーブル

| Column             | Type       | Options                        |
| name               | string     | null: false                    |
| price              | integer    | null: false                    |
| postage_id         | integer    | null: false                    |
| explanation        | text       | null: false                    |
| status_id          | string     | null: false                    |
| area_id            | string     | null: false                    |
| days_id            | integer    | null: false                    |
| category_id        | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :purchase

###　purchasesテーブル

| Column             | Type       | Options                        |
| user               | references | null: false, foreign_key: true |
| item               | references | null: false, foreign_key: true |

### Association
- belong_to :user
- belong_to :item
- has_one :address

## addressesテーブル
| Column             | Type       | Option                         |
| postal_code        | string     | null: false                    |
| area_id            | integer    | null: false                    |
| municipalities     | string     | null: false                    |
| address            | string     | null: false                    |
| building_name      | string     |                                |
| phone_number       | integer    | null: false                    |
| purchase           | references | null: false, foreign_key: true |

### Association
- belong_to :purchase