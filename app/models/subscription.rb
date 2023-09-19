class Subscription < ApplicationRecord
  has_many :user_subscriptions
  has_many :users, through: :user_subscriptions
  has_many :tea_subscriptions
  has_many :teas, through: :tea_subscriptions
end
