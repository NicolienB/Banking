# frozen_string_literal: true

class Transaction < ApplicationRecord
  #Delete white spaces for both bank accounts
  before_validation :delete_whitespace
  Currencylist = ["€", "$"]
  CreditOrDebitList = ["Credit","Debit"]
  #Ensures only valid bank accounts are accepted
  validates :bank_account, :contra_account,  format: {with: /\A[a-zA-Z]{2}[\s]*[0-9]{2}[\s]*[a-zA-Z]{4}[\s]*[0-9]{14}[\s]*\z/, message: "Please use the following format for the IBAN: GB92 AVVZ 46534230174644 "}
  validates :bank_account, :contra_account, length:{maximum: 22}
  #Ensures no characters other than whitespaces and letters can be used.
  validates :contra_account_owner, format: {with:/\A[a-zA-Z \s*]\z/, message: "Only letters and whitespaces are allowed"}
  #all fields are mandatory except for description  field
  validates :date, :bank_account, :contra_account, :contra_account_owner, :amount, :currency, :credit_or_debit,
            presence: true
  #you cannot make a transaction in the past
  validate :date, :DateValidation
  #Ensures the input amount is bigger than xero and the maximum amount of decimals is 2
  validates :amount, :numericality => { greater_than: 0, message: "The amount you want to transfer needs to be bigger than 0 represented in numbers, please use . as decimal point" }
  validates :amount, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/, message:"the amount cannot have more than two decimals"}
  # before_validation :bank_account,   :strip_whitespace
  def DateValidation
    if date.present? && date < Date.today
      errors.add(:date, "The date of transaction can only be today or in the future.")
    end
  end
  def delete_whitespace
    self.bank_account = self.bank_account.gsub(/[[:space:]]/, '') unless self.bank_account.nil?
    self.contra_account = self.contra_account.gsub(/[[:space:]]/, '') unless self.contra_account.nil?

  end

end


