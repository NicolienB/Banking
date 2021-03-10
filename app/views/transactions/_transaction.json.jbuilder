json.extract! transaction, :id, :description, :date, :bank_account, :contra_account, :contra_account_owner, :amount, :currency, :credit_or_debit, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
