class CreateTransaction
  include Interactor

  def call
    from_account = Account.find_by(id: context.transaction_params[:from_account_id])

    unless from_account
      context.fail!(errors: 'Sender account not found')
      return
    end

    to_account = Account.find_by(id: context.transaction_params[:to_account_id])
    unless to_account
      context.fail!(errors: 'Recipient account not found')
      return
    end

    balance = CalculateAccountBalance.call(account: from_account).balance
    if balance < context.transaction_params[:amount].to_d
      context.fail!(errors: 'Insufficient balance')
      return
    end

    transaction = Transaction.new(context.transaction_params)
    if transaction.save
      context.transaction = transaction
    else
      context.fail!(errors: transaction.errors)
    end
  end
end
