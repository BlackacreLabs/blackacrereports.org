class BlackacreReports < Sinatra::Base
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
