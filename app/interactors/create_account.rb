class CreateAccount
  include Interactor

  DIGITS = ("0".."9").to_a
  LETTERS = ("A".."Z").to_a
  ALPHANUMERIC = DIGITS + LETTERS

  def call
    account = Account.new(context.account_params)
    account.iban = generate_iban

    if account.save
      context.account = account
    else
      context.fail!(errors: account.errors)
    end
  end

  private

  def generate_iban
    country_code = context.account_params[:country_code]

    begin
      rules = IBANTools::Conversion.send(:load_config, country_code)
    rescue => e
      context.fail!(errors: e.message)
    end

    data = rules.to_h { |key, format| [ key.to_sym, random_value_for(format) ] }
    IBANTools::IBAN.from_local(country_code, data).code
  end

  def random_value_for(format)
    length = format.to_s.scan(/\d+/).first.to_i
    type = format.to_s[-1]

    chars = case type
    when "n" then DIGITS
    when "a" then LETTERS
    when "c" then ALPHANUMERIC
    else DIGITS
    end

    Array.new(length) { chars.sample }.join
  end
end
