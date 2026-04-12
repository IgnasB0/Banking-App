class WithdrawalsController < ApplicationController
  allow_unauthenticated_access
  before_action :authenticate_banking_facility

  def create
    result = CreateWithdrawal.call(
      banking_facility_id: @current_banking_facility.id,
      account_id: params[:account_id],
      amount: params[:amount]
    )

    if result.success?
      render json: result.withdrawal, status: :created
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end
end
