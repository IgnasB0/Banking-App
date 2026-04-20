class AccountsController < ApplicationController
  def index
    @accounts = Current.user.accounts.order(created_at: :desc)
    respond_to do |format|
      format.html
      format.json { render json: @accounts }
    end
  end

  def show
    account = Current.user.accounts.find(params[:id])
    balance_calculation = CalculateAccountBalance.call(account: account)
    render json: account.as_json.merge(balance: balance_calculation.balance)
  end

  def new
    @account = Account.new
  end

  def create
    result = CreateAccount.call(account_params: account_params, user: Current.user)
    if result.success?
      render json: result.account, status: :created
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  private

  def account_params
    params.expect(account: %i[first_name last_name country_code])
  end
end
