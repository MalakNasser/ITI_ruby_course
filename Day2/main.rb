require_relative 'bank_system'

users = [
  User.new("Ali", 200),
  User.new("Peter", 500),
  User.new("Manda", 100)
]

out_side_bank_users = [
  User.new("Menna", 400),
]

transactions = [
  Transaction.new(users[0], -20),
  Transaction.new(users[0], -30),
  Transaction.new(users[0], -50),
  Transaction.new(users[0], -100),
  Transaction.new(users[0], -100),
  Transaction.new(out_side_bank_users[0], -100)
]

cba_bank = CBABank.new

callback_block = ->(status, transaction, reason = nil) do
    if status == "succeeded"
        puts "Call endpoint for success of User #{transaction.user.name} with transaction value #{transaction.value}"
    elsif status == "failed"
        puts "Call endpoint for failure of User #{transaction.user.name} with transaction value #{transaction.value} with reason #{reason}"
    end
end

cba_bank.process_transactions(transactions, users, &callback_block)