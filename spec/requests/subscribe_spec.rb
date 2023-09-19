require "rails_helper"

RSpec.describe "Subscribe", type: :request do
  describe "Happy Path" do
    before :each do
      @user1 = User.create!(email: "javen@gmail.com", first_name: "Javen", last_name: "Wilson", address: "1234 Main St")
    end
    describe "POST /subscribe" do
      it "subscribes a user" do

        params = {email: @user1.email,
                  first_name: @user1.first_name,
                  last_name: @user1.last_name,
                  address: @user1.address,
                  subscribe: true,
                  tea_title: "Green Tea",
                  title: "Pro",
                  price: 10.00,
                  frequency: "Monthly",
                  status: "Active"
                }

        post "/api/v1/user/#{@user1.id}/subscribe", params: params

        expect(response).to have_http_status(200)

      end
    end
  end
end