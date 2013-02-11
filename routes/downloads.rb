# encoding: UTF-8

require 'cgi'

class BlackacreReports < Sinatra::Base
  NO_SUCH_FILE_ALERT = CGI::escape(
    "We’re sorry. The file you requested could not be found"
  )

  get '/pdf' do
    v, p = params.values_at(:volume, :page)
    number = params[:number]
    if v && p
      object = "/US/#{v}-US-#{p}.pdf"
    elsif number
      object = "/US/#{number}.pdf"
    end
    if object.nil? || !S3::S3Object.exists?(object, ENV['S3_BUCKET'])
      redirect to("/?alert=#{NO_SUCH_FILE_ALERT}")
    else
      redirect S3::S3Object.url_for(
        object, ENV['S3_BUCKET'],
        :use_ssl => true,
        :authenticated => false
      )
    end
  end
end
