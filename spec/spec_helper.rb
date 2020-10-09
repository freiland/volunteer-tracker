require 'rspec'
require 'pg'
require 'trains'
require 'cities'
require 'pry'

DB = PG.connect({:dbname => 'amtrak_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM trains *;")
    DB.exec("DELETE FROM cities *;")
  end
end