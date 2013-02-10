require_relative 'environment'

require 'haml'
require 'sinatra'
require 'sinatra/partial'
require 'bluebook/date_patch'
require 'date'

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
    @recent_cases = Case.desc(:decided)
    haml :index
  end

  get %r{^/US/(\d\d\d\d)/(.+)$} do
    year, citation = params[:captures]
    query = Case.decided_in(year.to_i)
    case citation
    when /^(\d+)-US-(\d+)$/ # reporter
      query = query.where(volume: $1.to_i, page: $2.to_i)
    when /^(\d\d-\d\d+)$/ # docket number
      query = query.where(number: $1)
    end
    @case = query.desc(:commit_time).first
    haml :case
  end
end
