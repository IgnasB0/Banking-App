class TransactionsController < ApplicationController
  skip_forgery_protection

  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.save
      render json: @transaction, status: :created
    else
      render json: { errors: @transaction.errors }, status: :unprocessable_entity
    end
  end

  private

  def transaction_params
    params.expect(transaction: [ :from_account_id, :to_account_id, :amount ])
  end
end
