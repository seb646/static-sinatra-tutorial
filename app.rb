require 'sinatra'

set :port, 8080
set :static, true
set :bind, '0.0.0.0'

get '/' do
    erb :index
end