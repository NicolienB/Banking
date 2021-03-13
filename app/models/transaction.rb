# frozen_string_literal: true

class Transaction < ApplicationRecord
  # extend AutoStripAttributes
  # include StripWhitespace
  # strip_whitespace_from_attributes : bank_account
  # before_validation auto_strip_attributes :bank_account, :contra_account
  # before_validation.gsub(/\s+/, "")
  before_validation :delete_whitespace
  Currencylist = ["€", "$"]
  CreditOrDebitList = ["Credit","Debit"]
  validates :bank_account, :contra_account,  format: {with: /\A[a-zA-Z]{2}[\s]*[0-9]{2}[\s]*[a-zA-Z]{4}[\s]*[0-9]{14}[\s]*\z/, message: "Please use the following format for the IBAN: GB92 AVVZ 46534230174644 "}
  validates :bank_account, :contra_account, length:{maximum: 22}
  validates :contra_account_owner, format: {with:/[a-zA-Z \s*]/, message: "Only letters and whitespaces are allowed"}
  # validates :date >= Date.now
  validates :date, :bank_account, :contra_account, :contra_account_owner, :amount, :currency, :credit_or_debit,
            presence: true
  validate :date, :DateValidation
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


