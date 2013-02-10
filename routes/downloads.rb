# encoding: UTF-8

require 'cgi'

class BlackacreReports < Sinatra::Base
  NO_SUCH_FILE_ALERT = CGI::escape(
    "We’re sorry. The file you requested could not be found"
  )

  get '/pdf' do
    v, p = params.values_at(:volume, :page)
    if v && p
      redirect S3::S3Object.url_for(
        "/US/#{v}-US-#{p}.pdf",
        ENV['S3_BUCKET'],
        :use_ssl => true,
        :authenticated => false
      )
    else
      redirect to("/?alert=#{NO_SUCH_FILE_ALERT}")
    end
  end
end
