# frozen_string_literal: true

unless $LOAD_PATH.include?(File.dirname(__FILE__)) || $LOAD_PATH.include?(__dir__)
  $LOAD_PATH.unshift(File.dirname(__FILE__))
end

module RSLT
  VERSION = '1.1.10'
end

require 'rslt/stylesheet'
require 'rslt/rule'
require 'rslt/element_wrapper'
