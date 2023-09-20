class Api::V1::UnsubscribeController < ApplicationController
  def update
    if params[:status] == "Inactive" && params[:sub_id].present?
      sub = Subscription.find(params[:sub_id])
      sub.update(status: params[:status])
      render json: SubscriptionSerializer.new(sub), status: :ok
    else
      render json: { errors: "Missing required fields" }, status: 400
    end
  end
end