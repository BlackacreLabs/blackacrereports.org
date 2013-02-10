require_relative 'environment'

require 'haml'
require 'logger'
require 'sinatra'
require 'sinatra/partial'

class BlackacreReports < Sinatra::Base
  register Sinatra::Partial
  set :partial_template_engine, :haml
  enable :partial_underscores

  set :haml, :format => :html5

  # Security
  configure :production do
    require 'rack-ssl-enforcer'
    use Rack::SslEnforcer
  end

  # Logging
  configure :production, :development do
    enable :logging
  end
  
  get '/' do
    haml :index
  end
end
