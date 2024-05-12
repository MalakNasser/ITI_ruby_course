require_relative 'logger'

class User
    attr_accessor :name, :balance

    def initialize(name, balance)
        @name = name 
        @balance = balance
    end
end

class Transaction
    attr_reader :user, :value

    def initialize(user, value)
        @user = user
        @value = value
    end
end

class Bank

    def process_transactions(transactions, users, &callback_block)
        raise "#{self.class}'s method (#{__method__}) is an abstract method. You must implement this method in your concrete subclass."
    end
end

class CBABank < Bank
    include Logger

    def process_transactions(transactions, users, &callback_block)
        transactions_details = transactions.map do |transaction|
            "User #{transaction.user.name} transaction with value #{transaction.value}"
        end.join(', ')
        Logger.log_info("Processing Transactions: #{transactions_details}....")

        transactions.each do |transaction|
            begin
                message = "User #{transaction.user.name} transaction with value #{transaction.value} "
                if !users.include?(transaction.user)
                    Logger.log_error(message + "failed with message #{transaction.user.name} not exist in the bank!!")
                    raise "#{transaction.user.name} not exist in the bank!!"
                elsif (transaction.user.balance + transaction.value) < 0 
                    Logger.log_error(message + "failed with message Not enough balance")
                    raise "Not enough balance"
                elsif (transaction.user.balance + transaction.value) == 0 
                    Logger.log_warning("#{transaction.user.name} has 0 balance")
                end
                transaction.user.balance += transaction.value
                Logger.log_info(message + "succeeded")
                callback_block.call("succeeded", transaction)
            rescue => e 
                callback_block.call("failed", transaction, e.message)
            end
        end
    end
end