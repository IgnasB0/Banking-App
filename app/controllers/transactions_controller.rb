class TransactionsController < ApplicationController
  def new; end

  def create
    result = CreateTransaction.call(transaction_params)
    if result.success?
      redirect_to accounts_path, notice: 'Transfer completed successfully.'
    else
      @error = result.errors
      render :new, status: :unprocessable_entity
    end
  end

  private

  def transaction_params
    {
      from_account_id: params.dig(:transaction, :from_account_id),
      to_iban: params.dig(:transaction, :to_iban),
      amount: params.dig(:transaction, :amount)
    }
  end
end
