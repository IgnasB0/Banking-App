class AccountsController < ApplicationController
  def index
    accounts = Account.order(created_at: :desc)
    render json: accounts
  end

  def show
    account = Account.find(params[:id])
    balance_calculation = CalculateAccountBalance.call(account: account)
    render json: account.as_json.merge(balance: balance_calculation.balance)
  end

  def new
    @account = Account.new
  end

  def create
    result = CreateAccount.call(account_params: account_params)
    if result.success?
      render json: result.account, status: :created
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  private

  def account_params
    params.expect(account: [ :first_name, :last_name, :country_code ])
  end
end
