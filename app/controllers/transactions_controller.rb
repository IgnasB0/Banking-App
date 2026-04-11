class TransactionsController < ApplicationController
  def create
    result = CreateTransaction.call(transaction_params: transaction_params)
    if result.success?
      render json: result.transaction, status: :created
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  private

  def transaction_params
    params.expect(transaction: %i[from_account_id to_account_id amount])
  end
end
