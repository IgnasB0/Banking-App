class CalculateAccountBalance
  include Interactor

  def call
    account = context.account

    deposits = Deposit.where(account_id: account.id).sum(:amount)
    withdrawals = Withdrawal.where(account_id: account.id).sum(:amount)
    received = Transaction.where(to_account_id: account.id).sum(:amount)
    sent = Transaction.where(from_account_id: account.id).sum(:amount)

    context.balance = deposits - withdrawals + received - sent
  end
end
