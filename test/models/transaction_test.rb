require "test_helper"

class TransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  #following tests check if required fields work as expected, the names are self explanatory
  test "is valid with all valid attributes" do
    transaction = Transaction.new(description:"This is some free money",bank_account: "GB92 AVVZ 46534230174644", contra_account: "GB92 AVVZ 46534230174644", date:Date.today,contra_account_owner:"Paul",amount: 10, currency: "Euro €",credit_or_debit: "Credit" )
    assert transaction.save
  end
  test "is valid without description,but valid attributes" do
    transaction = Transaction.new(bank_account: "GB92 AVVZ 46534230174644", contra_account: "GB92 AVVZ 46534230174644", date:Date.today,contra_account_owner:"Paul",amount: 10, currency: "Euro €",credit_or_debit: "Credit" )
    assert transaction.save
  end
  test "is invalid without bank_account" do
    transaction = Transaction.new(description:"This is some free money", contra_account: "GB92 AVVZ 46534230174644", date:Date.today,contra_account_owner:"Paul",amount: 10, currency: "Euro €",credit_or_debit: "Credit" )
    assert_not transaction.save
  end
  test "is invalid without contra_account" do
    transaction = Transaction.new(description:"This is some free money",bank_account: "GB92 AVVZ 46534230174644", date:Date.today,contra_account_owner:"Paul",amount: 10, currency: "Euro €",credit_or_debit: "Credit" )
    assert_not transaction.save
  end
  test "is invalid without Date" do
    transaction = Transaction.new(description:"This is some free money",bank_account: "GB92 AVVZ 46534230174644", contra_account: "GB92 AVVZ 46534230174644", contra_account_owner:"Paul",amount: 10, currency: "Euro €",credit_or_debit: "Credit" )
    assert_not transaction.save
  end
  test "is invalid without contra account owner" do
    transaction = Transaction.new(description:"This is some free money",bank_account: "GB92 AVVZ 46534230174644", contra_account: "GB92 AVVZ 46534230174644", date:Date.today,amount: 10, currency: "Euro €",credit_or_debit: "Credit" )
    assert_not transaction.save
  end
  test "is invalid without amount" do
    transaction = Transaction.new(description:"This is some free money",bank_account: "GB92 AVVZ 46534230174644", contra_account: "GB92 AVVZ 46534230174644", date:Date.today,contra_account_owner:"Paul", currency: "Euro €",credit_or_debit: "Credit" )
    assert_not transaction.save
  end
  test "is invalid without currency" do
    transaction = Transaction.new(description:"This is some free money",bank_account: "GB92 AVVZ 46534230174644", contra_account: "GB92 AVVZ 46534230174644", date:Date.today,contra_account_owner:"Paul",amount: 10,credit_or_debit: "Credit" )
    assert_not transaction.save
  end
  test "is invalid without Credit or Debit" do
    transaction = Transaction.new(description:"This is some free money",bank_account: "GB92 AVVZ 46534230174644", contra_account: "GB92 AVVZ 46534230174644", date:Date.today,contra_account_owner:"Paul",amount: 10, currency: "Euro €" )
    assert_not transaction.save
  end
#  The following tests test if only valid arguments are accepted
  test "is invalid with wrong bank account" do
    transaction = Transaction.new(description:"This is some free money",bank_account: "GB9 AVVZ 46534230174644", contra_account: "GB92 AVVZ 46534230174644", date:Date.today,contra_account_owner:"Paul",amount: 10, currency: "Euro €",credit_or_debit: "Credit" )
    assert_not transaction.save
  end
  test "is invalid with wrong contra account" do
    transaction = Transaction.new(description:"This is some free money",bank_account: "GB92 AVVZ 46534230174644", contra_account: "GB9 AVVZ 46534230174644", date:Date.today,contra_account_owner:"Paul",amount: 10, currency: "Euro €",credit_or_debit: "Credit" )
    assert_not transaction.save
  end
  test "is invalid with date in past" do
    transaction = Transaction.new(description:"This is some free money",bank_account: "GB92 AVVZ 46534230174644", contra_account: "GB92 AVVZ 46534230174644", date: Date.yesterday,contra_account_owner:"Paul",amount: 10, currency: "Euro €",credit_or_debit: "Credit" )
    assert_not transaction.save
  end
  test "is invalid with numbers in contra account owner" do
    transaction = Transaction.new(description:"This is some free money",bank_account: "GB92 AVVZ 46534230174644", contra_account: "GB92 AVVZ 46534230174644", date: Date.yesterday,contra_account_owner:"Paul1",amount: 10, currency: "Euro €",credit_or_debit: "Credit" )
    assert_not transaction.save
  end

  test "is invalid with amount with more than 2 decimals" do
    transaction = Transaction.new(description:"This is some free money",bank_account: "GB92 AVVZ 46534230174644", contra_account: "GB92 AVVZ 46534230174644", date: Date.yesterday,contra_account_owner:"Paul",amount: 0.001, currency: "Euro €",credit_or_debit: "Credit" )
    assert_not transaction.save
  end
  test "is invalid with wrong currency" do
    transaction = Transaction.new(description:"This is some free money",bank_account: "GB92 AVVZ 46534230174644", contra_account: "GB92 AVVZ 46534230174644", date: Date.yesterday,contra_account_owner:"Paul",amount: 10, currency: "Yuan",credit_or_debit: "Credit" )
    assert_not transaction.save
  end
  test "is invalid with different card than debit or credit" do
    transaction = Transaction.new(description:"This is some free money",bank_account: "GB92 AVVZ 46534230174644", contra_account: "GB92 AVVZ 46534230174644", date: Date.yesterday,contra_account_owner:"Paul",amount: 10, currency: "Euro €",credit_or_debit: "Bank" )
    assert_not transaction.save
  end
end
