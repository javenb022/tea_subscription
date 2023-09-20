class Api::V1::SubscriptionController < ApplicationController
  def index
    user = User.find(params[:user_id])
    subs = user.subscriptions
    teas = user.teas
    render json: SubscriptionSerializer.serialize_all(subs, teas), status: :ok
  end

  def create
    sub = Subscription.create(subscription_params)
    tea = Tea.find(params[:tea_id])
    if sub.save && user_check?
      create_user_subscription(sub.id, params[:id])
      render json: SubscriptionSerializer.serialize(sub, tea), status: :created
    else
      render json: { errors: "Missing required fields" }, status: :unprocessable_entity
    end
  end

  private

  def user_check?
    User.exists?(id: params[:id], first_name: params[:first_name], last_name: params[:last_name], email: params[:email], address: params[:address])
  end

  def subscription_params
    params.permit(:title, :price, :frequency, :status, :tea_id)
  end

  def create_user_subscription(sub_id, user_id)
    UserSubscription.create(user_id: user_id, subscription_id: sub_id)
  end
end