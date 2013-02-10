require_relative 'environment'

require 'sinatra'
require 'sinatra/partial'
require 'bluebook/date_patch'

require 'date'

class BlackacreReports < Sinatra::Base
  # Markup
  register Sinatra::Partial
  set :partial_template_engine, :haml
  enable :partial_underscores
  set :haml, :format => :html5

  # Logging
  configure :production, :development do
    enable :logging
  end

  # Analytics
  configure :production do
    require 'newrelic_rpm'
  end
  
  get '/' do
    @recent_cases = Case.head.desc(:decided)
    haml :index
  end
end

Dir['routes/*.rb'].each { |r| require_relative r }
