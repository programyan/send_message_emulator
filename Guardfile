# frozen_string_literal: true

guard :bundler do
  watch('Gemfile')
end

guard :rspec, cmd: 'bundle exec rspec' do
  watch(%r{^spec/spec_helper\.rb$}) { 'spec' }
  watch(%r{^app/controllers/application_controller\.rb$}) { 'spec/controllers' }
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^app/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
end
