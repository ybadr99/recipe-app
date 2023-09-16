require 'active_record'
# Load your Rails application's environment
require_relative 'environment'
# Test the database connection
begin
  ActiveRecord::Base.connection
  puts 'Database connection successful!'
rescue ActiveRecord::ConnectionNotEstablished
  puts 'Database connection failed!'
end
