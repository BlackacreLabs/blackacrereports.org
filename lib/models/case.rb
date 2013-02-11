# encoding: UTF-8

require 'mongoid'

class Case
  include Mongoid::Document

  # Content
  field :style,   type: String
  field :decided, type: Date
  field :argued,  type: Date
  field :volume,  type: Integer
  field :number,  type: String
  field :page,	  type: Integer

  # Versioning
  field :commit_hash, type: String
  field :commit_time, type: Time
  field :data_path,   type: String
  field :head,        type: Boolean, default: true
  scope :head, where(head: true)

  def self.decided_in(year)
    where(
      :decided.gte => Time.new(year, 1, 1),
      :decided.lte => Time.new(year, 12, 31)
    )
  end

  embeds_many :documents

  def href
    ret = StringIO.new
    ret << "/US/#{decided.year}/"
    if number
      ret << number.gsub(', ', '-')
    elsif volume && page
      ret << "#{volume}-US-#{page}"
    end
    ret.string
  end

  def pdf_href
    if volume && page
      "/pdf?volume=#{volume}&page=#{page}"
    else
      "/pdf?number=#{number}"
    end
  end

  def github_href
    if volume && page
      "#{ENV['GITHUB_BASE']}/reported_decisions/#{volume}/#{page}"
    elsif number && decided
      "#{ENV['GITHUB_BASE']}/slip_opinions/#{number}"
    end
  end

  def citation
    if volume && page
      "#{volume} U.S. #{page} (#{decided.year})"
    elsif number
      "No. #{number} (U.S., #{decided.to_bluebook})"
    end
  end
end
