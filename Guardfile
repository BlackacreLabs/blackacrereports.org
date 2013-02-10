guard 'bundler' do
  watch('Gemfile')
end

guard 'coffeescript', :input => 'public/js'

guard 'cucumber' do
  watch(%r{^features/.+\.feature$})
  watch(%r{^features/support/.+$}) { 'features' }
  watch(%r{^features/step_definitions/(.+)_steps\.rb$}) do |m|
    Dir[File.join("**/#{m[1]}.feature")][0] || 'features'
  end

  watch(%r{^spec/fabricators/.+\.rb$})

  watch(%r{^[^/].+\.rb})
  watch(%r{^(config|lib|app)/.*})
  watch(%r{^views/.+\.haml})
end

guard 'rack', :start_on_start => true, :server => :thin do
  watch('Gemfile.lock')
  watch('application.rb')
  watch(%r{^(config|lib|app)/.*})
end

guard 'rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb') { "spec" }
end

guard 'sass', :input => 'public/css'
