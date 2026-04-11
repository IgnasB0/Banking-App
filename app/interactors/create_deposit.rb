class CreateDeposit
  include Interactor

  def call
    deposit = Deposit.new(
      banking_facility_id: context.banking_facility_id,
      account_id: context.account_id,
      amount: context.amount
    )

    if deposit.save
      context.deposit = deposit
    else
      context.fail!(errors: deposit.errors)
    end
  end
end
