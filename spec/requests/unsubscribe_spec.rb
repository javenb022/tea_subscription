require "rails_helper"

RSpec.describe "Unsubscribe", type: :request do
  before :each do
    @user1 = User.create!(email: "javen@gmail.com", first_name: "Javen", last_name: "Wilson", address: "1234 Main St")
    @tea1 = Tea.create!(title: "Earl Grey", description: "Tea", temperature: 200, brew_time: 5)
    @tea2 = Tea.create!(title: "Green Tea", description: "Tea", temperature: 200, brew_time: 5)
    @sub1 = Subscription.create!(title: "Pro", price: 10.00, frequency: "Monthly", status: "Active")
  end

  describe "Happy Path" do
    describe "PATCH /unsubscribe" do
      it "unsubscribes a user" do
        params = {
          sub_id: @sub1.id,
          status: "Inactive"
        }

        patch "/api/v1/users/#{@user1.id}/unsubscribe", params: params

        expect(response).to be_successful
        expect(response).to have_http_status(200)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:data]).to have_key(:id)
        expect(json[:data][:id]).to be_a(String)
        expect(json[:data]).to have_key(:type)
        expect(json[:data][:type]).to eq("subscription")
        expect(json[:data]).to have_key(:attributes)
        expect(json[:data][:attributes]).to have_key(:title)
        expect(json[:data][:attributes][:title]).to eq(@sub1.title)
        expect(json[:data][:attributes]).to have_key(:price)
        expect(json[:data][:attributes][:price]).to eq(@sub1.price)
        expect(json[:data][:attributes]).to have_key(:frequency)
        expect(json[:data][:attributes][:frequency]).to eq(@sub1.frequency)
        expect(json[:data][:attributes]).to have_key(:status)
        expect(json[:data][:attributes][:status]).to eq(params[:status])
      end
    end
  end

  describe "Sad Path" do
    describe "PATCH /unsubscribe" do
      it "returns an error if a required field is missing" do
        params = {
          sub_id: @sub1.id,
          # status: "Inactive"
        }

        patch "/api/v1/users/#{@user1.id}/unsubscribe", params: params

        expect(response).to_not be_successful
        expect(response).to have_http_status(400)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:errors]).to eq("Missing required fields")
      end

      it "returns an error if a required field is missing" do
        params = {
          # sub_id: @sub1.id,
          status: "Inactive"
        }

        patch "/api/v1/users/#{@user1.id}/unsubscribe", params: params

        expect(response).to_not be_successful
        expect(response).to have_http_status(400)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:errors]).to eq("Missing required fields")
      end
    end
  end
end