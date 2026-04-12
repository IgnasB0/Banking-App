# frozen_string_literal: true

# Transfers an amount from one account to another, looked up by IBAN.
class CreateTransaction
  include Interactor

  def call
    from_account = find_sender
    to_account = find_recipient
    verify_balance(from_account)
    save_transaction(from_account, to_account)
  end

  private

  def find_sender
    account = Account.find_by(id: context.from_account_id)
    context.fail!(errors: 'Sender account not found') unless account
    account
  end

  def find_recipient
    account = Account.find_by(iban: context.to_iban)
    context.fail!(errors: 'Recipient account not found') unless account
    account
  end

  def verify_balance(from_account)
    balance = CalculateAccountBalance.call(account: from_account).balance
    context.fail!(errors: 'Insufficient balance') if balance < context.amount.to_d
  end

  def save_transaction(from_account, to_account)
    transaction = Transaction.new(
      from_account_id: from_account.id,
      to_account_id: to_account.id,
      amount: context.amount
    )
    if transaction.save
      context.transaction = transaction
    else
      context.fail!(errors: transaction.errors)
    end
  end
end
