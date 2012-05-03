require 'rubygems'
require 'rest_client'

url = "http://expenseitserver.heroku.com/expenses"
RestClient.delete url 
