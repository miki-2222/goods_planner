class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      # 外部キー
      t.references :user, null: false, foreign_key: true

      # 基本情報
      t.string :name, null: false
      t.integer :price
      t.text :memo

      # 0: 予約前(planned), 10: 予約中(reserved), 20: 購入済み(purchased)
      t.integer :status, default: 0, null: false

      # 日付情報
      t.date :release_date              # 発売日
      t.date :reservation_start_date    # 予約開始日
      t.date :reservation_end_date      # 予約終了日
      t.date :purchased_at              # 購入日

      t.timestamps
    end

    # インデックス
    add_index :items, [:user_id, :status]
    add_index :items, [:user_id, :created_at]
  end
end
