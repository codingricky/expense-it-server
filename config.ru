require './server'
run Sinatra::Application

use Rack::Static, 
  :urls => ["/stylesheets", "/images"],
  :root => "public"