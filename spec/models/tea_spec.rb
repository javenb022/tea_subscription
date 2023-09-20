require "rails_helper"

RSpec.describe Tea, type: :model do
  describe "relationships" do
    it {should have_many :subscriptions}
    it {should have_many(:user_subscriptions).through(:subscriptions)}
    it {should have_many(:users).through(:user_subscriptions)}
  end
end