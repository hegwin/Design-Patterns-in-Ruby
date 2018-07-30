require 'etc'
require './bank_account'

class AccountProtectionProxy < BasicObject
  def initialize(real_account, owner_name)
    @subject    = real_account
    @owner_name = owner_name
  end

  def method_missing(method_name, *args)
    check_access
    @subject.send method_name, *args
  end

  def check_access
    if ::Etc.getlogin != @owner_name
      raise 'Permission denied'
    end
  end
end

bank_account = BankAccount.new 100
proxy = AccountProtectionProxy.new bank_account, 'hegwin'

proxy.deposit 200
p proxy.balance

proxy.withdraw 50
p proxy.balance
