class User < ApplicationRecord
  has_many :user_subscriptions
  has_many :subscriptions, through: :user_subscriptions
  has_many :tea_subscriptions, through: :subscriptions
  has_many :teas, through: :tea_subscriptions
end
