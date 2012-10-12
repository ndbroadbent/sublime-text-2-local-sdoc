# Gemfile
require "rubygems"
require "bundler/setup"
require "sinatra"
require "sinatra/reloader" if ENV['SINATRA_ENV'] == 'dev'
require File.expand_path("../local_sdoc", __FILE__)

disable :run
set :raise_errors, true
set :root, Pathname(__FILE__).dirname

run Sinatra::Application
