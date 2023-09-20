class Api::V1::SubscribeController < ApplicationController
  def create
    sub = Subscription.create(subscription_params)
    tea = Tea.find(params[:tea_id])
    if sub.save && user_check?
      create_user_subscription(sub.id, params[:id])
      create_teas_subscription(sub.id, params[:tea_id])
      render json: SubscribeSerializer.serialize(sub, tea), status: :created
    else
      render json: { errors: "Missing required fields" }, status: :unprocessable_entity
    end
  end

  private

  def user_check?
    User.exists?(id: params[:id], first_name: params[:first_name], last_name: params[:last_name], email: params[:email], address: params[:address])
  end

  def subscription_params
    params.permit(:title, :price, :frequency, :status)
  end

  def create_user_subscription(sub_id, user_id)
    UserSubscription.create(user_id: user_id, subscription_id: sub_id)
  end

  def create_teas_subscription(sub_id, tea_id)
    TeaSubscription.create(tea_id: tea_id, subscription_id: sub_id)
  end
end