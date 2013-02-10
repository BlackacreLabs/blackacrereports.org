# encoding: UTF-8

require 'fileutils'
require 'json'
require 'precedent'
require 'date'
require 'time'
require 'tmpdir'
require 'yaml'

require 'logger'
$log = Logger.new STDOUT

require_relative '../environment'

def preserialize(hash)
  hash.reduce({}) do |mem, (key, value)|
    case value
    when Date
      mem[key.to_s] = value.to_time
    when Array
      mem[key.to_s] = value.map do |e|
        e.is_a?(Hash) ? preserialize(e) : e
      end
    else
      mem[key.to_s] = value
    end
    mem
  end
end

def case_hash(dir, hash, time)
  FileUtils.cd(dir) do
    meta = YAML::load_file('case.yml')
    meta['number'] &&= meta['number'].gsub('–','-')
    return preserialize(meta.merge({
      'commit_hash' => hash,
      'commit_time' => time,
      'data_path' => dir,
      'documents' => Dir['*.pre'].map do |file|
        hash = Precedent.load(File.read(file))
        doc_meta = hash.delete(:meta) || {}
        hash.merge(doc_meta)
      end
    }))
  end
end

REPO = ENV['DATA_REPO']
raise "No DATA_REPO specified" if REPO.nil? || REPO.empty?

LAST_SYNC = Synchronization.last
if LAST_SYNC
  $log.info "Last sync time: #{LAST_SYNC.time}"
  $log.info "Last sync commit: #{LAST_SYNC.commit_hash}"
end

Dir.mktmpdir do |dir|
  $log.info "Cloning #{REPO} to #{dir}"
  `git clone "#{REPO}" "#{dir}"`

  # Move into the temporary directory
  FileUtils.cd dir

  # HEAD commit data
  HEAD_HASH = `git rev-parse HEAD`.strip
  $log.info "HEAD: #{HEAD_HASH}"
  HEAD_TIME = Time.parse(`git show -s --format="%ci" HEAD`.strip)
  $log.info "Committed: #{HEAD_TIME}"

  if LAST_SYNC
    last_hash = LAST_SYNC.commit_hash
    changed = `git diff --name-only "#{last_hash}"`
    changed = changed.split("\n")
    $log.info "#{changed.count} changed since #{last_hash}"
    changed.map { |l|
      File.dirname(l)
    }.uniq.each { |dir|
      next unless File.exist?(File.join(dir, 'case.yml'))
      $log.info dir
      Case.create(case_hash(dir, HEAD_HASH, HEAD_TIME))
    }
  else
    $log.info "No previous synchronization"
    Dir['**/case.yml'].each do |yaml|
      dir = File.dirname(yaml)
      $log.info dir
      Case.create(case_hash(dir, HEAD_HASH, HEAD_TIME))
    end
  end

  $log.info "Logging the sync"
  Synchronization.create(
    time: Time.now,
    commit_hash: HEAD_HASH,
    commit_time: HEAD_TIME
  )
end
