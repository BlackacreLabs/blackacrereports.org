guard 'bundler' do
  watch('Gemfile')
end

guard 'coffeescript', :input => 'public/js'

guard 'rack', :server => :thin do
  watch('Gemfile.lock')
  watch('application.rb')
  watch('environment.rb')
  watch(%r{^(config|lib|routes)/.*})
end

guard 'rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb') { "spec" }

  watch(%r{^spec/features/(.+)\.feature$})
  watch(%r{^spec/features/steps/(.+)_steps\.rb$}) do |m|
    Dir[File.join("**/#{m[1]}.feature")][0] || 'spec/features'
  end
end

guard 'sass', :input => 'public/css'
