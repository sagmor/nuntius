require 'bundler/setup'

require 'nuntius'

Dir["spec/support/**/*.rb"].each { |f| require File.expand_path(f) }

RSpec.configure do |config|
  # some (optional) config here
end
