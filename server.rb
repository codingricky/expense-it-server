require 'sinatra'
require 'json'
require 'mongo'

post '/expense' do
  expense = JSON.parse(request.body.read)
  
  connection = Mongo::Connection.new
  db = connection.db("mydb")
  coll = db["expenses"]
  id = coll.insert(expense)
  puts id
  id.to_s
end

get '/expense' do
   connection = Mongo::Connection.new
   db = connection.db("mydb")
   coll = db["expenses"]
   expenses = coll.find.collect {|expense| expense.to_json}
   
   expenses.join
end