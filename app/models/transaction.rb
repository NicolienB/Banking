# frozen_string_literal: true

class Transaction < ApplicationRecord
  Currencylist = ["Euro €", "Dollar $"]
  CreditOrDebitList = ["Credit","Debit"]
  validates :bank_account, :contra_account, format: {with: /[a-zA-Z]{2}[\s]*[0-9]{2}[\s]*[a-zA-Z]{4}[\s]*[0-9]{14}[\s]*/, message: "Please use the following format for the IBAN: GB92 AVVZ 46534230174644 "}

end


