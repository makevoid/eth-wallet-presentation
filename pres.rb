require 'sinatra'
require 'haml'

class Pres < Sinatra::Base
  get "/" do
    haml :index
  end
end
