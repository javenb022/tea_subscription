class Tea < ApplicationRecord
  has_many :subscriptions
  has_many :user_subscriptions, through: :subscriptions
  has_many :users, through: :user_subscriptions
end
