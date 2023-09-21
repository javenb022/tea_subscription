require "rails_helper"

RSpec.describe "Subscribe", type: :request do
  before :each do
    @user1 = User.create!(email: "javen@gmail.com", first_name: "Javen", last_name: "Wilson", address: "1234 Main St")
    @tea1 = Tea.create!(title: "Earl Grey", description: "Tea", temperature: 200, brew_time: 5)
    @tea2 = Tea.create!(title: "Green Tea", description: "Tea", temperature: 200, brew_time: 5)
  end
  describe "Happy Path" do
    describe "POST /subscribe" do
      it "subscribes a user" do

        params = {email: @user1.email,
                  first_name: @user1.first_name,
                  last_name: @user1.last_name,
                  address: @user1.address,
                  subscribe: true,
                  tea_id: @tea1.id,
                  title: "Pro",
                  price: 10.00,
                  frequency: "Monthly",
                  status: "Active"
                }

        post "/api/v1/users/#{@user1.id}/subscribe", params: params

        expect(response).to be_successful
        expect(response).to have_http_status(201)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:data]).to have_key(:id)
        expect(json[:data][:id]).to be_an(Integer)
        expect(json[:data]).to have_key(:type)
        expect(json[:data][:type]).to eq("subscription")
        expect(json[:data]).to have_key(:attributes)
        expect(json[:data][:attributes]).to have_key(:title)
        expect(json[:data][:attributes][:title]).to eq(params[:title])
        expect(json[:data][:attributes]).to have_key(:price)
        expect(json[:data][:attributes][:price]).to eq(params[:price])
        expect(json[:data][:attributes]).to have_key(:frequency)
        expect(json[:data][:attributes][:frequency]).to eq(params[:frequency])
        expect(json[:data][:attributes]).to have_key(:status)
        expect(json[:data][:attributes][:status]).to eq(params[:status])
        expect(json[:data]).to have_key(:tea_info)
        expect(json[:data][:tea_info]).to have_key(:tea_id)
        expect(json[:data][:tea_info][:tea_id]).to eq(@tea1.id)
        expect(json[:data][:tea_info]).to have_key(:tea_title)
        expect(json[:data][:tea_info][:tea_title]).to eq(@tea1.title)
        expect(json[:data][:tea_info]).to have_key(:tea_description)
        expect(json[:data][:tea_info][:tea_description]).to eq(@tea1.description)
        expect(json[:data][:tea_info]).to have_key(:tea_temperature)
        expect(json[:data][:tea_info][:tea_temperature]).to eq(@tea1.temperature)
      end
    end
  end

  describe "Sad Path" do
    it "returns an error if a required field is missing" do
      params = {
                email: @user1.email,
                first_name: @user1.first_name,
                last_name: @user1.last_name,
                # address: @user1.address,
                subscribe: true,
                tea_id: @tea1.id,
                title: "Pro",
                price: 10.00,
                frequency: "Monthly",
                status: "Active"
              }

      post "/api/v1/users/#{@user1.id}/subscribe", params: params

      expect(response).to_not be_successful
      expect(response).to have_http_status(422)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:errors]).to eq("Missing required fields")
    end
  end
end