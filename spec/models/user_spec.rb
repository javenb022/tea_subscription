require "rails_helper"

RSpec.describe User, type: :model do
  describe "relationships" do
    it {should have_many :user_subscriptions}
    it {should have_many(:subscriptions).through(:user_subscriptions)}
    it {should have_many(:tea_subscriptions).through(:subscriptions)}
    it {should have_many(:teas).through(:tea_subscriptions)}
  end

  describe "validations" do
    it {should validate_presence_of :first_name}
    it {should validate_presence_of :last_name}
    it {should validate_presence_of :email}
    it {should validate_presence_of :address}
  end
end