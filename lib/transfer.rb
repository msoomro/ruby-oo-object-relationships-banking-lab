class Transfer
  attr_accessor :status
  attr_reader :sender, :receiver, :amount
  @@all = []

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
    @@all << self
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    message = ""
    if self.status == "pending" && valid? && sender.balance >= amount
      sender.balance = sender.balance - amount
      receiver.balance = receiver.balance + amount
      message = "completed"
      @status = "complete"
    else
      message = "Transaction rejected. Please check your account balance."
      @status = "rejected"
    end
    message
  end

  def reverse_transfer
    if self.status == "complete"
      t = Transfer.new(receiver, sender, amount)
      t.execute_transaction
      @status = "reversed"
    else
      puts "Transfer cannot be reversed."
    end

  end

end
