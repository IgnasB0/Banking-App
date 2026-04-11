class DepositsController < ApplicationController

  before_action :authenticate_banking_facility

  def create
    result = CreateDeposit.call(
      banking_facility_id: @current_banking_facility.id,
      account_id: params[:account_id],
      amount: params[:amount]
    )

    if result.success?
      render json: result.deposit, status: :created
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end
end
