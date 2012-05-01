require 'rubygems'
require 'json'
require 'rest_client'

expense = {:name => 'John Smith'}
receipt_1 = {:client => 'Jemena', :category => 'Travel', :date => '24/4/2012', :amount_in_cents => 1212, :description => 'Taxi from City to SOP'}
receipt_2 = {:client => 'ResMed', :category => 'Travel', :date => '25/4/2012', :amount_in_cents => 9923, :description => 'Taxi from City to Bella Vista'}
expense[:receipts] = [receipt_1, receipt_2]

url = 'http://localhost:4567/expense'
response = RestClient.post url, expense.to_json
puts response

# File.open('output.xls', 'w') {|f| f.write response}