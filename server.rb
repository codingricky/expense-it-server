require 'sinatra'
require 'json'
require 'mongo'
requre 'base64'

get '/hello' do
  "hello"
end

post '/expense' do
  expense = JSON.parse(request.body.read)
  coll = get_col
  id = coll.insert(expense)
  id.to_s
end

get '/expense/:id/receipts/:index/image' do |id, index|
  coll = get_col
  
  begin
    expense = coll.find("_id" => BSON::ObjectId(id)).to_a[0].to_json
    
    content_type "image/png"
    Base64.decode64 expense["receipts"][index]["image"]
    
  rescue
    status 404
    "Expense not found"
  end  
   
end

get '/expense' do
  coll = get_col
  expenses = coll.find.collect {|expense| expense.to_json}
   
  expenses.join
end

get '/expense/:id' do |id|
  coll = get_col
     
  begin
    coll.find("_id" => BSON::ObjectId(id)).to_a[0].to_json
  rescue
    status 404
    "Expense not found"
  end
end

delete '/expense' do
  coll = get_col
  
  coll.remove
  coll.count.to_s
end

def get_col
  if ENV['MONGOHQ_URL'] 
    uri = URI.parse(ENV['MONGOHQ_URL'])
    conn = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
    db = conn.db(uri.path.gsub(/^\//, ''))
    db["expenses"]
  else
    connection = Mongo::Connection.new
    db = connection.db("mydb")
    db["expenses"]
  end
end
