require 'rubygems'
require 'rest_client'

url = "http://localhost:4567/expenses"
RestClient.delete url 
