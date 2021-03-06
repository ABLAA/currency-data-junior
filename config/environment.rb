# Setting the app envirement
ENV['SINATRA_ENV'] ||= "development"
ENV['RACK_ENV'] ||= "development"
# Add the needed requirement to boot the app
require 'bundler/setup'
require 'rubygems'
require 'data_mapper'
require 'excon'
require 'net/http'
require 'json'
Bundler.require(:default, ENV['SINATRA_ENV'])


# Setting DataMapper database connection
# Having trouble with database or you want to change the adapter ?! check https://datamapper.org/getting-started.html
DataMapper.setup(:default, 'postgres://postgres:123@localhost/money')
# Loading all the files in app folder
require_all 'app'