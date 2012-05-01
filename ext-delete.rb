require 'rubygems'
require 'rest_client'

url = "http://expenseitserver.heroku.com/expense"
RestClient.delete url 
