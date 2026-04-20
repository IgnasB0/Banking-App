class TransfersController < ApplicationController
  def new; end

  def create
    result = CreateTransfer.call(transfer_params)
    if result.success?
      redirect_to accounts_path, notice: "Transfer completed successfully."
    else
      @error = result.errors
      render :new, status: :unprocessable_entity
    end
  end

  def index
    account_id = params[:account_id]
    account = Current.user.accounts.find(params[:account_id])
    if account
      transfers = Transfer.where('from_account_id = ? OR to_account_id = ?', account_id)

      render json: transfers, status: :ok
    else
      render status :not_found
    end
  end

  private

  def transfer_params
    {
      from_account_id: params.dig(:transfer, :from_account_id),
      to_iban: params.dig(:transfer, :to_iban),
      amount: params.dig(:transfer, :amount)
    }
  end
end
