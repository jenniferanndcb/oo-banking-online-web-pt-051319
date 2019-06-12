require 'pry'

class Transfer
  attr_accessor :sender, :receiver, :status, :amount, :bank_account 
  
  def initialize(sender,receiver,amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end 
  
  def valid? 
    sender.valid? && receiver.valid?
  end 
  
  def execute_transaction
    if valid? && self.status != "complete"
      sender.balance -= self.amount
      receiver.balance += self.amount
      self.status = "complete"
    end 
    if sender.balance > self.amount
      self.status = 'rejected'
      "Transaction rejected. Please check your account balance."
    end 
   end
  
  def reverse_transfer 
    if execute_transaction
      self.sender.balance += self.amount
      self.receiver.balance -= self.amount 
      self.status = "reversed"
    end 
  end 
  
end
