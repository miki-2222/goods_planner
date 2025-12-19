class Item < ApplicationRecord
  belongs_to :user

  enum status: {
    planned: 0,    # 予約前（購入予定）
    reserved: 10,      # 予約中
    purchased: 20      # 購入済み（所持品）
  }

  validates :name, presence: true
  validates :status, presence: true
  validates :price, numericality: { 
    only_integer: true,           # 整数のみ
    greater_than_or_equal_to: 0,  # 0以上
    less_than: 100000000          # 1億円未満
  }, allow_blank: true              # 空欄を許可

  scope :planned, -> { where(status: [:planned, :reserved]) }
  scope :owned, -> { where(status: :purchased) }
  scope :recent, -> { order(created_at: :desc) }
  scope :by_status, ->(status) { where(status: status) if status.present? }
end