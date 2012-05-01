require 'sinatra'
require 'json'
require 'mongo'

get '/hello' do
  "hello"
end

post '/expense' do
  expense = JSON.parse(request.body.read)
  uri = URI.parse(ENV['MONGOHQ_URL'])
  conn = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
  db = conn.db(uri.path.gsub(/^\//, ''))
  coll = db["expenses"]
  id = coll.insert(expense)
  id.to_s
end

get '/expense' do
  uri = URI.parse(ENV['MONGOHQ_URL'])
  conn = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
  db = conn.db(uri.path.gsub(/^\//, ''))
  coll = db["expenses"]
  expenses = coll.find.collect {|expense| expense.to_json}
   
  expenses.join
end

get '/expense/:id' do |id|
  connection = Mongo::Connection.new
  db = connection.db("mydb")
  coll = db["expenses"]
  
  begin
    coll.find("_id" => BSON::ObjectId(id)).to_a[0].to_json
  rescue
    status 404
    "Expense not found"
  end
end

delete '/expense' do
  coll = Mongo::Connection.new.db("mydb")["expenses"]
  
  coll.remove
  coll.count.to_s
end