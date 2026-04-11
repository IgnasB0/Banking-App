class CreateWithdrawal
  include Interactor

  def call
    withdrawal = Withdrawal.new(
      banking_facility_id: context.banking_facility_id,
      account_id: context.account_id,
      amount: context.amount
    )

    if withdrawal.save
      context.withdrawal = withdrawal
    else
      context.fail!(errors: withdrawal.errors)
    end
  end
end
