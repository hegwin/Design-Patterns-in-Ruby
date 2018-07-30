require './bank_account'

class VirtualAccountProxy < BasicObject
  def initialize(&creation_block)
    @creation_block = creation_block
  end

  def method_missing(method_name, *args)
    subject.send method_name, *args
  end

  def subject
    @subject ||= @creation_block.()
  end
end

account = VirtualAccountProxy.new { BankAccount.new 100 }
account.withdraw 50

p account.balance
