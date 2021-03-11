class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.string :description
      t.date :date
      t.string :bank_account
      t.string :contra_account
      t.string :contra_account_owner
      t.float :amount
      t.string :currency
      t.string :credit_or_debit

      t.timestamps
    end
  end
end
