$: << File.dirname(__FILE__) + '/../lib/'
require 'rubygems'
require 'mocha'
require 'redgreen' unless ENV["RUN_CODE_RUN"] || Object.const_defined?("TextMate")
require 'test/spec'
