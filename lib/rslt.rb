$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module RSLT
  VERSION = '1.1.10'
end

require 'nokogiri'
require 'builder'
require 'rslt/stylesheet'
require 'rslt/rule'
require 'rslt/element_wrapper'
