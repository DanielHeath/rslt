$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Excesselt
  VERSION = '1.1.7'
end

require 'excesselt/stylesheet'
require 'excesselt/rule'
require 'excesselt/element_wrapper'
