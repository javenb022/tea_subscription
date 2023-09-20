require "rails_helper"

RSpec.describe "Get all subscriptions for a User", type: :request do
  before(:each) do
    @user1 = User.create!(email: "javen@gmail.com", first_name: "Javen", last_name: "Wilson", address: "1234 Main St")
    @user2 = User.create!(email: "bob@gmail.com", first_name: "Bob", last_name: "Kojak", address: "456 West St")
    @tea1 = Tea.create!(title: "Earl Grey", description: "Tea", temperature: 200, brew_time: 5)
    @tea2 = Tea.create!(title: "Green Tea", description: "Tea", temperature: 200, brew_time: 5)
    @tea3 = Tea.create!(title: "Black Tea", description: "Tea", temperature: 200, brew_time: 5)
    @sub1 = Subscription.create!(title: "Pro", price: 10.00, frequency: "Monthly", status: "Active", tea_id: @tea1.id)
    @sub2 = Subscription.create!(title: "Adict", price: 15.00, frequency: "Monthly", status: "Active", tea_id: @tea2.id)
    @sub3 = Subscription.create!(title: "Basic", price: 5.00, frequency: "Monthly", status: "Active", tea_id: @tea3.id)
    @user_sub1 = UserSubscription.create!(user_id: @user1.id, subscription_id: @sub1.id)
    @user_sub2 = UserSubscription.create!(user_id: @user1.id, subscription_id: @sub2.id)
    @user_sub3 = UserSubscription.create!(user_id: @user2.id, subscription_id: @sub3.id)
  end
  describe "Happy Path" do
    describe "GET /users/:user_id/subscriptions" do
      it "returns all subscriptions for a user" do
        get "/api/v1/users/#{@user1[:id]}/subscriptions"

        expect(response).to be_successful
        expect(response).to have_http_status(200)

        json = JSON.parse(response.body, symbolize_names: true)
        # require 'pry'; binding.pry
        expect(json.count).to eq(2)
        expect(json[0][:data]).to have_key(:id)
        expect(json[0][:data][:id]).to be_an(Integer)
        expect(json[0][:data]).to have_key(:type)
        expect(json[0][:data][:type]).to eq("subscription")
        expect(json[0][:data]).to have_key(:attributes)
        expect(json[0][:data][:attributes]).to have_key(:title)
        expect(json[0][:data][:attributes][:title]).to eq(@sub1.title)
        expect(json[0][:data][:attributes]).to have_key(:price)
        expect(json[0][:data][:attributes][:price]).to eq(@sub1.price)
        expect(json[0][:data][:attributes]).to have_key(:frequency)
        expect(json[0][:data][:attributes][:frequency]).to eq(@sub1.frequency)
        expect(json[0][:data][:attributes]).to have_key(:status)
        expect(json[0][:data][:attributes][:status]).to eq(@sub1.status)
        expect(json[0][:data]).to have_key(:tea_info)
        expect(json[0][:data][:tea_info]).to have_key(:tea_id)
        expect(json[0][:data][:tea_info][:tea_id]).to eq(@tea1.id)
        expect(json[0][:data][:tea_info]).to have_key(:tea_title)
        expect(json[0][:data][:tea_info][:tea_title]).to eq(@tea1.title)
        expect(json[0][:data][:tea_info]).to have_key(:tea_description)
        expect(json[0][:data][:tea_info][:tea_description]).to eq(@tea1.description)
        expect(json[0][:data][:tea_info]).to have_key(:tea_temperature)
        expect(json[0][:data][:tea_info][:tea_temperature]).to eq(@tea1.temperature)

        expect(json[1][:data]).to have_key(:id)
        expect(json[1][:data][:id]).to be_an(Integer)
        expect(json[1][:data]).to have_key(:type)
        expect(json[1][:data][:type]).to eq("subscription")
        expect(json[1][:data]).to have_key(:attributes)
        expect(json[1][:data][:attributes]).to have_key(:title)
        expect(json[1][:data][:attributes][:title]).to eq(@sub2.title)
        expect(json[1][:data][:attributes]).to have_key(:price)
        expect(json[1][:data][:attributes][:price]).to eq(@sub2.price)
        expect(json[1][:data][:attributes]).to have_key(:frequency)
        expect(json[1][:data][:attributes][:frequency]).to eq(@sub2.frequency)
        expect(json[1][:data][:attributes]).to have_key(:status)
        expect(json[1][:data][:attributes][:status]).to eq(@sub2.status)
        expect(json[1][:data]).to have_key(:tea_info)
        expect(json[1][:data][:tea_info]).to have_key(:tea_id)
        expect(json[1][:data][:tea_info][:tea_id]).to eq(@tea2.id)
        expect(json[1][:data][:tea_info]).to have_key(:tea_title)
        expect(json[1][:data][:tea_info][:tea_title]).to eq(@tea2.title)
        expect(json[1][:data][:tea_info]).to have_key(:tea_description)
        expect(json[1][:data][:tea_info][:tea_description]).to eq(@tea2.description)
        expect(json[1][:data][:tea_info]).to have_key(:tea_temperature)
        expect(json[1][:data][:tea_info][:tea_temperature]).to eq(@tea2.temperature)
      end
    end
  end
end